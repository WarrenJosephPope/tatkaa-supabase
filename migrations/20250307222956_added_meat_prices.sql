drop policy "Enable delete for authenticated users" on "public"."meat_gallery";

drop policy "Enable insert for authenticated users only" on "public"."meat_gallery";

drop policy "Enable read access for all users" on "public"."meat_gallery";

drop policy "Enable update for authenticated users" on "public"."meat_gallery";

revoke delete on table "public"."meat_gallery" from "anon";

revoke insert on table "public"."meat_gallery" from "anon";

revoke references on table "public"."meat_gallery" from "anon";

revoke select on table "public"."meat_gallery" from "anon";

revoke trigger on table "public"."meat_gallery" from "anon";

revoke truncate on table "public"."meat_gallery" from "anon";

revoke update on table "public"."meat_gallery" from "anon";

revoke delete on table "public"."meat_gallery" from "authenticated";

revoke insert on table "public"."meat_gallery" from "authenticated";

revoke references on table "public"."meat_gallery" from "authenticated";

revoke select on table "public"."meat_gallery" from "authenticated";

revoke trigger on table "public"."meat_gallery" from "authenticated";

revoke truncate on table "public"."meat_gallery" from "authenticated";

revoke update on table "public"."meat_gallery" from "authenticated";

revoke delete on table "public"."meat_gallery" from "service_role";

revoke insert on table "public"."meat_gallery" from "service_role";

revoke references on table "public"."meat_gallery" from "service_role";

revoke select on table "public"."meat_gallery" from "service_role";

revoke trigger on table "public"."meat_gallery" from "service_role";

revoke truncate on table "public"."meat_gallery" from "service_role";

revoke update on table "public"."meat_gallery" from "service_role";

alter table "public"."meat_gallery" drop constraint "meat_gallery_meat_id_fkey";

alter table "public"."meat_gallery" drop constraint "meat_gallery_media_id_fkey";

alter table "public"."meat_gallery" drop constraint "meat_gallery_pkey";

drop index if exists "public"."meat_gallery_pkey";

drop table "public"."meat_gallery";

create table "public"."gallery" (
    "created_at" timestamp with time zone not null default now(),
    "meat_id" uuid not null,
    "media_id" uuid not null
);


alter table "public"."gallery" enable row level security;

create table "public"."price_categories" (
    "id" uuid not null default gen_random_uuid(),
    "name" text not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."price_categories" enable row level security;

create table "public"."prices" (
    "id" uuid not null default gen_random_uuid(),
    "price_categories_id" uuid,
    "name" text not null,
    "price" numeric not null default '0'::numeric,
    "sold_per" metric not null default 'kg'::metric,
    "minimum_quantity" numeric not null,
    "created_at" timestamp with time zone not null default now(),
    "meat_id" uuid not null
);


alter table "public"."prices" enable row level security;

alter table "public"."cart_items" alter column "price_type" drop default;

alter table "public"."cart_items" alter column "price_type" set data type text using "price_type"::text;

alter table "public"."meat" drop column "chilli_cut_price";

alter table "public"."meat" drop column "cleaned_with_head_price";

alter table "public"."meat" drop column "cleaned_without_head_price";

alter table "public"."meat" drop column "head_price";

alter table "public"."meat" drop column "large_cut_price";

alter table "public"."meat" drop column "medium_cut_price";

alter table "public"."meat" drop column "metric";

alter table "public"."meat" drop column "small_cut_price";

alter table "public"."meat" drop column "uncleaned_with_head_price";

alter table "public"."meat" drop column "uncleaned_without_head_price";

alter table "public"."meat" drop column "uses_cut_meat_price";

alter table "public"."meat" drop column "uses_whole_meat_price";

alter table "public"."order_details" alter column "price_type" drop default;

alter table "public"."order_details" alter column "price_type" set data type text using "price_type"::text;

CREATE UNIQUE INDEX price_categories_pkey ON public.price_categories USING btree (id);

CREATE UNIQUE INDEX prices_pkey ON public.prices USING btree (id);

CREATE UNIQUE INDEX meat_gallery_pkey ON public.gallery USING btree (meat_id, media_id);

alter table "public"."gallery" add constraint "meat_gallery_pkey" PRIMARY KEY using index "meat_gallery_pkey";

alter table "public"."price_categories" add constraint "price_categories_pkey" PRIMARY KEY using index "price_categories_pkey";

alter table "public"."prices" add constraint "prices_pkey" PRIMARY KEY using index "prices_pkey";

alter table "public"."gallery" add constraint "meat_gallery_meat_id_fkey" FOREIGN KEY (meat_id) REFERENCES meat(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."gallery" validate constraint "meat_gallery_meat_id_fkey";

alter table "public"."gallery" add constraint "meat_gallery_media_id_fkey" FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."gallery" validate constraint "meat_gallery_media_id_fkey";

alter table "public"."prices" add constraint "prices_meat_id_fkey" FOREIGN KEY (meat_id) REFERENCES meat(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."prices" validate constraint "prices_meat_id_fkey";

alter table "public"."prices" add constraint "prices_price_categories_id_fkey" FOREIGN KEY (price_categories_id) REFERENCES price_categories(id) ON UPDATE CASCADE ON DELETE SET NULL not valid;

alter table "public"."prices" validate constraint "prices_price_categories_id_fkey";

grant delete on table "public"."gallery" to "anon";

grant insert on table "public"."gallery" to "anon";

grant references on table "public"."gallery" to "anon";

grant select on table "public"."gallery" to "anon";

grant trigger on table "public"."gallery" to "anon";

grant truncate on table "public"."gallery" to "anon";

grant update on table "public"."gallery" to "anon";

grant delete on table "public"."gallery" to "authenticated";

grant insert on table "public"."gallery" to "authenticated";

grant references on table "public"."gallery" to "authenticated";

grant select on table "public"."gallery" to "authenticated";

grant trigger on table "public"."gallery" to "authenticated";

grant truncate on table "public"."gallery" to "authenticated";

grant update on table "public"."gallery" to "authenticated";

grant delete on table "public"."gallery" to "service_role";

grant insert on table "public"."gallery" to "service_role";

grant references on table "public"."gallery" to "service_role";

grant select on table "public"."gallery" to "service_role";

grant trigger on table "public"."gallery" to "service_role";

grant truncate on table "public"."gallery" to "service_role";

grant update on table "public"."gallery" to "service_role";

grant delete on table "public"."price_categories" to "anon";

grant insert on table "public"."price_categories" to "anon";

grant references on table "public"."price_categories" to "anon";

grant select on table "public"."price_categories" to "anon";

grant trigger on table "public"."price_categories" to "anon";

grant truncate on table "public"."price_categories" to "anon";

grant update on table "public"."price_categories" to "anon";

grant delete on table "public"."price_categories" to "authenticated";

grant insert on table "public"."price_categories" to "authenticated";

grant references on table "public"."price_categories" to "authenticated";

grant select on table "public"."price_categories" to "authenticated";

grant trigger on table "public"."price_categories" to "authenticated";

grant truncate on table "public"."price_categories" to "authenticated";

grant update on table "public"."price_categories" to "authenticated";

grant delete on table "public"."price_categories" to "postgres";

grant insert on table "public"."price_categories" to "postgres";

grant references on table "public"."price_categories" to "postgres";

grant select on table "public"."price_categories" to "postgres";

grant trigger on table "public"."price_categories" to "postgres";

grant truncate on table "public"."price_categories" to "postgres";

grant update on table "public"."price_categories" to "postgres";

grant delete on table "public"."price_categories" to "service_role";

grant insert on table "public"."price_categories" to "service_role";

grant references on table "public"."price_categories" to "service_role";

grant select on table "public"."price_categories" to "service_role";

grant trigger on table "public"."price_categories" to "service_role";

grant truncate on table "public"."price_categories" to "service_role";

grant update on table "public"."price_categories" to "service_role";

grant delete on table "public"."prices" to "anon";

grant insert on table "public"."prices" to "anon";

grant references on table "public"."prices" to "anon";

grant select on table "public"."prices" to "anon";

grant trigger on table "public"."prices" to "anon";

grant truncate on table "public"."prices" to "anon";

grant update on table "public"."prices" to "anon";

grant delete on table "public"."prices" to "authenticated";

grant insert on table "public"."prices" to "authenticated";

grant references on table "public"."prices" to "authenticated";

grant select on table "public"."prices" to "authenticated";

grant trigger on table "public"."prices" to "authenticated";

grant truncate on table "public"."prices" to "authenticated";

grant update on table "public"."prices" to "authenticated";

grant delete on table "public"."prices" to "postgres";

grant insert on table "public"."prices" to "postgres";

grant references on table "public"."prices" to "postgres";

grant select on table "public"."prices" to "postgres";

grant trigger on table "public"."prices" to "postgres";

grant truncate on table "public"."prices" to "postgres";

grant update on table "public"."prices" to "postgres";

grant delete on table "public"."prices" to "service_role";

grant insert on table "public"."prices" to "service_role";

grant references on table "public"."prices" to "service_role";

grant select on table "public"."prices" to "service_role";

grant trigger on table "public"."prices" to "service_role";

grant truncate on table "public"."prices" to "service_role";

grant update on table "public"."prices" to "service_role";

create policy "Enable delete for authenticated users"
on "public"."gallery"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for authenticated users only"
on "public"."gallery"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."gallery"
as permissive
for select
to public
using (true);


create policy "Enable update for authenticated users"
on "public"."gallery"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."price_categories"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."price_categories"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."price_categories"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."price_categories"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."prices"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."prices"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read for all users"
on "public"."prices"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."prices"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));



