alter table "public"."orders" drop column "delivering_start_time";

alter table "public"."orders" add column "delivered_on" timestamp with time zone;

alter table "public"."orders" add column "delivery_start_time" timestamp with time zone;

alter table "public"."orders" add column "invoice_number" text;

alter table "public"."orders" add column "paid_on" timestamp with time zone;

grant delete on table "public"."approved_pincodes" to "postgres";

grant insert on table "public"."approved_pincodes" to "postgres";

grant references on table "public"."approved_pincodes" to "postgres";

grant select on table "public"."approved_pincodes" to "postgres";

grant trigger on table "public"."approved_pincodes" to "postgres";

grant truncate on table "public"."approved_pincodes" to "postgres";

grant update on table "public"."approved_pincodes" to "postgres";

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


