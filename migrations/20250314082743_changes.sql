alter table "public"."gallery" drop constraint "meat_gallery_pkey";

drop index if exists "public"."meat_gallery_pkey";

create table "public"."coupon_meat" (
    "coupon_id" uuid not null,
    "meat_id" uuid not null
);


alter table "public"."coupon_meat" enable row level security;

create table "public"."coupon_usage" (
    "user_id" uuid not null,
    "coupon_id" uuid not null,
    "usage" bigint not null default '0'::bigint
);


alter table "public"."coupon_usage" enable row level security;

create table "public"."coupon_user" (
    "coupon_id" uuid not null,
    "user_id" uuid not null
);


alter table "public"."coupon_user" enable row level security;

create table "public"."coupons" (
    "code" text not null,
    "min_buy" numeric not null default '0'::numeric,
    "max_discount" numeric not null default '0'::numeric,
    "start_date" timestamp with time zone,
    "end_date" timestamp with time zone,
    "active" boolean not null default true,
    "hidden" boolean not null default false,
    "discount" numeric not null default '0'::numeric,
    "is_percent" boolean not null default false,
    "created_at" timestamp with time zone not null default now(),
    "id" uuid not null default gen_random_uuid(),
    "for_meat" boolean not null default false,
    "for_user" boolean not null default false
);


alter table "public"."coupons" enable row level security;

alter table "public"."gallery" add column "position" numeric not null default '0'::numeric;

alter table "public"."meat" add column "is_best_seller" boolean not null default false;

alter table "public"."order_details" add column "tax" numeric not null default '0'::numeric;

alter table "public"."orders" add column "coupon" text;

CREATE UNIQUE INDEX coupon_meat_pkey ON public.coupon_meat USING btree (coupon_id, meat_id);

CREATE UNIQUE INDEX coupon_usage_pkey ON public.coupon_usage USING btree (user_id, coupon_id);

CREATE UNIQUE INDEX coupon_user_pkey ON public.coupon_user USING btree (coupon_id, user_id);

CREATE UNIQUE INDEX coupons_code_key ON public.coupons USING btree (code);

CREATE UNIQUE INDEX coupons_pkey ON public.coupons USING btree (id);

CREATE UNIQUE INDEX gallery_pkey ON public.gallery USING btree (meat_id, media_id);

alter table "public"."coupon_meat" add constraint "coupon_meat_pkey" PRIMARY KEY using index "coupon_meat_pkey";

alter table "public"."coupon_usage" add constraint "coupon_usage_pkey" PRIMARY KEY using index "coupon_usage_pkey";

alter table "public"."coupon_user" add constraint "coupon_user_pkey" PRIMARY KEY using index "coupon_user_pkey";

alter table "public"."coupons" add constraint "coupons_pkey" PRIMARY KEY using index "coupons_pkey";

alter table "public"."gallery" add constraint "gallery_pkey" PRIMARY KEY using index "gallery_pkey";

alter table "public"."coupon_meat" add constraint "coupon_meat_coupon_id_fkey" FOREIGN KEY (coupon_id) REFERENCES coupons(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."coupon_meat" validate constraint "coupon_meat_coupon_id_fkey";

alter table "public"."coupon_meat" add constraint "coupon_meat_meat_id_fkey" FOREIGN KEY (meat_id) REFERENCES meat(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."coupon_meat" validate constraint "coupon_meat_meat_id_fkey";

alter table "public"."coupon_usage" add constraint "coupon_usage_coupon_id_fkey" FOREIGN KEY (coupon_id) REFERENCES coupons(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."coupon_usage" validate constraint "coupon_usage_coupon_id_fkey";

alter table "public"."coupon_usage" add constraint "coupon_usage_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."coupon_usage" validate constraint "coupon_usage_user_id_fkey";

alter table "public"."coupon_user" add constraint "coupon_user_coupon_id_fkey" FOREIGN KEY (coupon_id) REFERENCES coupons(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."coupon_user" validate constraint "coupon_user_coupon_id_fkey";

alter table "public"."coupon_user" add constraint "coupon_user_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."coupon_user" validate constraint "coupon_user_user_id_fkey";

alter table "public"."coupons" add constraint "coupons_code_key" UNIQUE using index "coupons_code_key";

grant delete on table "public"."coupon_meat" to "anon";

grant insert on table "public"."coupon_meat" to "anon";

grant references on table "public"."coupon_meat" to "anon";

grant select on table "public"."coupon_meat" to "anon";

grant trigger on table "public"."coupon_meat" to "anon";

grant truncate on table "public"."coupon_meat" to "anon";

grant update on table "public"."coupon_meat" to "anon";

grant delete on table "public"."coupon_meat" to "authenticated";

grant insert on table "public"."coupon_meat" to "authenticated";

grant references on table "public"."coupon_meat" to "authenticated";

grant select on table "public"."coupon_meat" to "authenticated";

grant trigger on table "public"."coupon_meat" to "authenticated";

grant truncate on table "public"."coupon_meat" to "authenticated";

grant update on table "public"."coupon_meat" to "authenticated";

grant delete on table "public"."coupon_meat" to "postgres";

grant insert on table "public"."coupon_meat" to "postgres";

grant references on table "public"."coupon_meat" to "postgres";

grant select on table "public"."coupon_meat" to "postgres";

grant trigger on table "public"."coupon_meat" to "postgres";

grant truncate on table "public"."coupon_meat" to "postgres";

grant update on table "public"."coupon_meat" to "postgres";

grant delete on table "public"."coupon_meat" to "service_role";

grant insert on table "public"."coupon_meat" to "service_role";

grant references on table "public"."coupon_meat" to "service_role";

grant select on table "public"."coupon_meat" to "service_role";

grant trigger on table "public"."coupon_meat" to "service_role";

grant truncate on table "public"."coupon_meat" to "service_role";

grant update on table "public"."coupon_meat" to "service_role";

grant delete on table "public"."coupon_usage" to "anon";

grant insert on table "public"."coupon_usage" to "anon";

grant references on table "public"."coupon_usage" to "anon";

grant select on table "public"."coupon_usage" to "anon";

grant trigger on table "public"."coupon_usage" to "anon";

grant truncate on table "public"."coupon_usage" to "anon";

grant update on table "public"."coupon_usage" to "anon";

grant delete on table "public"."coupon_usage" to "authenticated";

grant insert on table "public"."coupon_usage" to "authenticated";

grant references on table "public"."coupon_usage" to "authenticated";

grant select on table "public"."coupon_usage" to "authenticated";

grant trigger on table "public"."coupon_usage" to "authenticated";

grant truncate on table "public"."coupon_usage" to "authenticated";

grant update on table "public"."coupon_usage" to "authenticated";

grant delete on table "public"."coupon_usage" to "postgres";

grant insert on table "public"."coupon_usage" to "postgres";

grant references on table "public"."coupon_usage" to "postgres";

grant select on table "public"."coupon_usage" to "postgres";

grant trigger on table "public"."coupon_usage" to "postgres";

grant truncate on table "public"."coupon_usage" to "postgres";

grant update on table "public"."coupon_usage" to "postgres";

grant delete on table "public"."coupon_usage" to "service_role";

grant insert on table "public"."coupon_usage" to "service_role";

grant references on table "public"."coupon_usage" to "service_role";

grant select on table "public"."coupon_usage" to "service_role";

grant trigger on table "public"."coupon_usage" to "service_role";

grant truncate on table "public"."coupon_usage" to "service_role";

grant update on table "public"."coupon_usage" to "service_role";

grant delete on table "public"."coupon_user" to "anon";

grant insert on table "public"."coupon_user" to "anon";

grant references on table "public"."coupon_user" to "anon";

grant select on table "public"."coupon_user" to "anon";

grant trigger on table "public"."coupon_user" to "anon";

grant truncate on table "public"."coupon_user" to "anon";

grant update on table "public"."coupon_user" to "anon";

grant delete on table "public"."coupon_user" to "authenticated";

grant insert on table "public"."coupon_user" to "authenticated";

grant references on table "public"."coupon_user" to "authenticated";

grant select on table "public"."coupon_user" to "authenticated";

grant trigger on table "public"."coupon_user" to "authenticated";

grant truncate on table "public"."coupon_user" to "authenticated";

grant update on table "public"."coupon_user" to "authenticated";

grant delete on table "public"."coupon_user" to "postgres";

grant insert on table "public"."coupon_user" to "postgres";

grant references on table "public"."coupon_user" to "postgres";

grant select on table "public"."coupon_user" to "postgres";

grant trigger on table "public"."coupon_user" to "postgres";

grant truncate on table "public"."coupon_user" to "postgres";

grant update on table "public"."coupon_user" to "postgres";

grant delete on table "public"."coupon_user" to "service_role";

grant insert on table "public"."coupon_user" to "service_role";

grant references on table "public"."coupon_user" to "service_role";

grant select on table "public"."coupon_user" to "service_role";

grant trigger on table "public"."coupon_user" to "service_role";

grant truncate on table "public"."coupon_user" to "service_role";

grant update on table "public"."coupon_user" to "service_role";

grant delete on table "public"."coupons" to "anon";

grant insert on table "public"."coupons" to "anon";

grant references on table "public"."coupons" to "anon";

grant select on table "public"."coupons" to "anon";

grant trigger on table "public"."coupons" to "anon";

grant truncate on table "public"."coupons" to "anon";

grant update on table "public"."coupons" to "anon";

grant delete on table "public"."coupons" to "authenticated";

grant insert on table "public"."coupons" to "authenticated";

grant references on table "public"."coupons" to "authenticated";

grant select on table "public"."coupons" to "authenticated";

grant trigger on table "public"."coupons" to "authenticated";

grant truncate on table "public"."coupons" to "authenticated";

grant update on table "public"."coupons" to "authenticated";

grant delete on table "public"."coupons" to "postgres";

grant insert on table "public"."coupons" to "postgres";

grant references on table "public"."coupons" to "postgres";

grant select on table "public"."coupons" to "postgres";

grant trigger on table "public"."coupons" to "postgres";

grant truncate on table "public"."coupons" to "postgres";

grant update on table "public"."coupons" to "postgres";

grant delete on table "public"."coupons" to "service_role";

grant insert on table "public"."coupons" to "service_role";

grant references on table "public"."coupons" to "service_role";

grant select on table "public"."coupons" to "service_role";

grant trigger on table "public"."coupons" to "service_role";

grant truncate on table "public"."coupons" to "service_role";

grant update on table "public"."coupons" to "service_role";

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

create policy "Enable delete for admins only"
on "public"."coupon_meat"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins only"
on "public"."coupon_meat"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."coupon_meat"
as permissive
for select
to public
using (true);


create policy "Enable update for admins only"
on "public"."coupon_meat"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."coupon_usage"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for authorized users"
on "public"."coupon_usage"
as permissive
for insert
to authenticated
with check (((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))) OR (user_id = auth.uid())));


create policy "Enable read access for all users"
on "public"."coupon_usage"
as permissive
for select
to public
using (true);


create policy "Enable update for authorized users"
on "public"."coupon_usage"
as permissive
for update
to authenticated
using (((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))) OR (user_id = auth.uid())));


create policy "Enable delete for admins"
on "public"."coupon_user"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."coupon_user"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read for all authorized users"
on "public"."coupon_user"
as permissive
for select
to authenticated
using (((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))) OR (user_id = auth.uid())));


create policy "Enable update for admins"
on "public"."coupon_user"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."coupons"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."coupons"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."coupons"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."coupons"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));



