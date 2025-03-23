create table "public"."time_slots" (
    "id" uuid not null default gen_random_uuid(),
    "start_time" time with time zone not null,
    "end_time" time with time zone not null,
    "cutoff_time" time with time zone not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."time_slots" enable row level security;

alter table "public"."orders" drop column "delivering_on";

alter table "public"."orders" add column "delivering_start_time" timestamp with time zone;

alter table "public"."orders" add column "delivery_end_time" timestamp with time zone;

CREATE UNIQUE INDEX time_slots_pkey ON public.time_slots USING btree (id);

alter table "public"."time_slots" add constraint "time_slots_pkey" PRIMARY KEY using index "time_slots_pkey";

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

grant delete on table "public"."time_slots" to "anon";

grant insert on table "public"."time_slots" to "anon";

grant references on table "public"."time_slots" to "anon";

grant select on table "public"."time_slots" to "anon";

grant trigger on table "public"."time_slots" to "anon";

grant truncate on table "public"."time_slots" to "anon";

grant update on table "public"."time_slots" to "anon";

grant delete on table "public"."time_slots" to "authenticated";

grant insert on table "public"."time_slots" to "authenticated";

grant references on table "public"."time_slots" to "authenticated";

grant select on table "public"."time_slots" to "authenticated";

grant trigger on table "public"."time_slots" to "authenticated";

grant truncate on table "public"."time_slots" to "authenticated";

grant update on table "public"."time_slots" to "authenticated";

grant delete on table "public"."time_slots" to "postgres";

grant insert on table "public"."time_slots" to "postgres";

grant references on table "public"."time_slots" to "postgres";

grant select on table "public"."time_slots" to "postgres";

grant trigger on table "public"."time_slots" to "postgres";

grant truncate on table "public"."time_slots" to "postgres";

grant update on table "public"."time_slots" to "postgres";

grant delete on table "public"."time_slots" to "service_role";

grant insert on table "public"."time_slots" to "service_role";

grant references on table "public"."time_slots" to "service_role";

grant select on table "public"."time_slots" to "service_role";

grant trigger on table "public"."time_slots" to "service_role";

grant truncate on table "public"."time_slots" to "service_role";

grant update on table "public"."time_slots" to "service_role";


