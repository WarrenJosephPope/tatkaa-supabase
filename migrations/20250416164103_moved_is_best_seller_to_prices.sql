drop view if exists "public"."prices_with_meat_view";

alter table "public"."meat" drop column "is_best_seller";

alter table "public"."prices" add column "is_best_seller" boolean not null default false;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.get_average_order_value(start_date timestamp without time zone DEFAULT NULL::timestamp without time zone, end_date timestamp without time zone DEFAULT NULL::timestamp without time zone)
 RETURNS TABLE(date date, average_order_value numeric)
 LANGUAGE sql
AS $function$
  select 
    paid_on::DATE as date,
    COALESCE(SUM(total) / NULLIF(COUNT(id), 0), 0) as average_order_value
  from orders
  where is_paid = true
    and (start_date IS NULL OR paid_on >= start_date)
    and (end_date IS NULL OR paid_on <= end_date)
  group by date
  order by date;
$function$
;

CREATE OR REPLACE FUNCTION public.get_best_sellers(interval_type text)
 RETURNS TABLE(category text, total_sold integer)
 LANGUAGE sql
AS $function$
select 
    c.name as category, 
    count(od.meat_id) as total_sold
from order_details od
join meat m on od.meat_id = m.id
join categories_meat cm on m.id = cm.meat_id
join categories c on cm.category_id = c.id
join orders o on od.order_id = o.id
where o.is_paid = true 
    and o.paid_on is not null
    and o.paid_on >= 
        case 
            when interval_type = 'day' then now() - interval '1 day'
            when interval_type = 'week' then now() - interval '7 days'
            when interval_type = 'month' then now() - interval '30 days'
        end
group by c.name
order by total_sold desc
limit 5;
$function$
;

CREATE OR REPLACE FUNCTION public.get_top_customers_by_order_value(start_date timestamp without time zone DEFAULT NULL::timestamp without time zone, end_date timestamp without time zone DEFAULT NULL::timestamp without time zone)
 RETURNS TABLE(customer_name text, total_order_value numeric)
 LANGUAGE sql
AS $function$
  SELECT 
    p.name AS customer_name,
    SUM(o.total) AS total_order_value
  FROM orders o
  JOIN profiles p ON o.user_id = p.user_id
  WHERE o.is_paid = TRUE
    AND (start_date IS NULL OR (o.paid_on AT TIME ZONE 'Asia/Kolkata') >= start_date)
    AND (end_date IS NULL OR (o.paid_on AT TIME ZONE 'Asia/Kolkata') <= end_date)
  GROUP BY p.name
  ORDER BY total_order_value DESC;
$function$
;

CREATE OR REPLACE FUNCTION public.get_top_selling_products(start_date timestamp without time zone DEFAULT NULL::timestamp without time zone, end_date timestamp without time zone DEFAULT NULL::timestamp without time zone)
 RETURNS TABLE(meat_name text, price_type text, purchase_count bigint)
 LANGUAGE sql
AS $function$
  select 
    m.name || ' - ' || m.bengali_name || ' (' || od.price_type || ')' as meat_name,
    od.price_type,
    count(distinct od.order_id) as purchase_count
  from order_details od
  join meat m on od.meat_id = m.id
  join orders o on od.order_id = o.id
  where o.is_paid = true
    and (start_date IS NULL OR (o.paid_on AT TIME ZONE 'Asia/Kolkata')::DATE >= start_date)
    and (end_date IS NULL OR (o.paid_on AT TIME ZONE 'Asia/Kolkata')::DATE <= end_date)
  group by m.name, m.bengali_name, od.price_type
  order by purchase_count DESC;
$function$
;

CREATE OR REPLACE FUNCTION public.get_total_revenue_by_date(start_date date DEFAULT NULL::date, end_date date DEFAULT NULL::date)
 RETURNS TABLE(date date, total_revenue numeric)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT DATE(paid_on) AS date, COALESCE(SUM(total), 0)::NUMERIC AS total_revenue
  FROM orders
  WHERE is_paid = TRUE
    AND (start_date IS NULL OR paid_on >= start_date)
    AND (end_date IS NULL OR paid_on <= end_date)
  GROUP BY DATE(paid_on)
  ORDER BY date;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_total_sales_by_date(start_date date DEFAULT NULL::date, end_date date DEFAULT NULL::date)
 RETURNS TABLE(date date, total_sales integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT (paid_on AT TIME ZONE 'Asia/Kolkata')::DATE AS date, 
         COUNT(*)::INT AS total_sales
  FROM orders
  WHERE is_paid = TRUE
    AND (start_date IS NULL OR (paid_on AT TIME ZONE 'Asia/Kolkata')::DATE >= start_date)
    AND (end_date IS NULL OR (paid_on AT TIME ZONE 'Asia/Kolkata')::DATE <= end_date)
  GROUP BY (paid_on AT TIME ZONE 'Asia/Kolkata')::DATE
  ORDER BY date;
END;
$function$
;

create or replace view "public"."prices_with_meat_view" as  SELECT p.id AS price_id,
    p.name AS price_name,
    p.price,
    p.sold_per,
    p.minimum_quantity,
    p.tax,
    p.increment,
    p.available AS price_available,
    p.created_at AS price_created_at,
    pm.src AS price_media_src,
    pm.alt AS price_media_alt,
    pm.created_at AS price_media_created_at,
    pc.name AS price_category_name,
    pc.created_at AS price_category_created_at,
    m.id AS meat_id,
    m.name AS meat_name,
    m.bengali_name AS meat_bengali_name,
    m.description AS meat_description,
    m.rarity AS meat_rarity,
    m.available AS meat_available,
    m.slug AS meat_slug,
    m.created_at AS meat_created_at,
    COALESCE(json_agg(DISTINCT jsonb_build_object('meat_id', g.meat_id, 'media_id', g.media_id, 'position', g."position")) FILTER (WHERE (g.meat_id IS NOT NULL)), '[]'::json) AS galleries,
    COALESCE(json_agg(DISTINCT jsonb_build_object('category_id', c.id, 'category_name', c.name, 'category_slug', c.slug, 'category_media', jsonb_build_object('src', cm_media.src, 'alt', cm_media.alt, 'created_at', cm_media.created_at))) FILTER (WHERE (c.id IS NOT NULL)), '[]'::json) AS categories,
    COALESCE(array_agg(DISTINCT c.id) FILTER (WHERE (c.id IS NOT NULL)), '{}'::uuid[]) AS category_ids
   FROM (((((((prices p
     JOIN meat m ON ((p.meat_id = m.id)))
     LEFT JOIN media pm ON ((p.media_id = pm.id)))
     LEFT JOIN price_categories pc ON ((p.price_categories_id = pc.id)))
     LEFT JOIN gallery g ON ((m.id = g.meat_id)))
     LEFT JOIN categories_meat cm ON ((m.id = cm.meat_id)))
     LEFT JOIN categories c ON ((cm.category_id = c.id)))
     LEFT JOIN media cm_media ON ((c.media_id = cm_media.id)))
  GROUP BY p.id, pm.id, pc.id, m.id;


grant delete on table "public"."approved_pincodes" to "postgres";

grant insert on table "public"."approved_pincodes" to "postgres";

grant references on table "public"."approved_pincodes" to "postgres";

grant select on table "public"."approved_pincodes" to "postgres";

grant trigger on table "public"."approved_pincodes" to "postgres";

grant truncate on table "public"."approved_pincodes" to "postgres";

grant update on table "public"."approved_pincodes" to "postgres";

grant delete on table "public"."delivery_slabs" to "postgres";

grant insert on table "public"."delivery_slabs" to "postgres";

grant references on table "public"."delivery_slabs" to "postgres";

grant select on table "public"."delivery_slabs" to "postgres";

grant trigger on table "public"."delivery_slabs" to "postgres";

grant truncate on table "public"."delivery_slabs" to "postgres";

grant update on table "public"."delivery_slabs" to "postgres";

grant delete on table "public"."homepage_banner" to "postgres";

grant insert on table "public"."homepage_banner" to "postgres";

grant references on table "public"."homepage_banner" to "postgres";

grant select on table "public"."homepage_banner" to "postgres";

grant trigger on table "public"."homepage_banner" to "postgres";

grant truncate on table "public"."homepage_banner" to "postgres";

grant update on table "public"."homepage_banner" to "postgres";

grant delete on table "public"."page_seo" to "postgres";

grant insert on table "public"."page_seo" to "postgres";

grant references on table "public"."page_seo" to "postgres";

grant select on table "public"."page_seo" to "postgres";

grant trigger on table "public"."page_seo" to "postgres";

grant truncate on table "public"."page_seo" to "postgres";

grant update on table "public"."page_seo" to "postgres";

grant delete on table "public"."settings" to "postgres";

grant insert on table "public"."settings" to "postgres";

grant references on table "public"."settings" to "postgres";

grant select on table "public"."settings" to "postgres";

grant trigger on table "public"."settings" to "postgres";

grant truncate on table "public"."settings" to "postgres";

grant update on table "public"."settings" to "postgres";

grant delete on table "public"."time_slots" to "postgres";

grant insert on table "public"."time_slots" to "postgres";

grant references on table "public"."time_slots" to "postgres";

grant select on table "public"."time_slots" to "postgres";

grant trigger on table "public"."time_slots" to "postgres";

grant truncate on table "public"."time_slots" to "postgres";

grant update on table "public"."time_slots" to "postgres";


