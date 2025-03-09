alter table "public"."meat" add column "bengali_name" text;

alter table "public"."prices" add column "tax" numeric not null default '0'::numeric;

grant delete on table "public"."price_categories" to "postgres";

grant insert on table "public"."price_categories" to "postgres";

grant references on table "public"."price_categories" to "postgres";

grant select on table "public"."price_categories" to "postgres";

grant trigger on table "public"."price_categories" to "postgres";

grant truncate on table "public"."price_categories" to "postgres";

grant update on table "public"."price_categories" to "postgres";

grant delete on table "public"."prices" to "postgres";

grant insert on table "public"."prices" to "postgres";

grant references on table "public"."prices" to "postgres";

grant select on table "public"."prices" to "postgres";

grant trigger on table "public"."prices" to "postgres";

grant truncate on table "public"."prices" to "postgres";

grant update on table "public"."prices" to "postgres";


