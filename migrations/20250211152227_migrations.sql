create type "public"."metric" as enum ('kg', 'g');

create type "public"."order_status" as enum ('pending', 'canceled', 'confirmed', 'delivering', 'completed');

create type "public"."price_type" as enum ('uncleaned_with_head', 'cleaned_with_head', 'uncleaned_without_head', 'cleaned_without_head', 'small_cut', 'medium_cut', 'large_cut', 'chilli_cut', 'head');

create type "public"."user_role" as enum ('admin', 'user');

create table "public"."addresses" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "name" text not null,
    "address" text not null,
    "pincode" text not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."addresses" enable row level security;

create table "public"."cart_items" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "fish_id" uuid not null,
    "metric" metric not null default 'kg'::metric,
    "price_type" price_type not null default 'medium_cut'::price_type,
    "weight" numeric not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."cart_items" enable row level security;

create table "public"."categories" (
    "id" uuid not null default gen_random_uuid(),
    "name" text not null,
    "media_id" uuid,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."categories" enable row level security;

create table "public"."categories_fishes" (
    "category_id" uuid not null,
    "fish_id" uuid not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."categories_fishes" enable row level security;

create table "public"."fishes" (
    "id" uuid not null default gen_random_uuid(),
    "name" text not null,
    "description" text,
    "rarity" bigint not null default '0'::bigint,
    "available" boolean not null default false,
    "metric" metric not null default 'kg'::metric,
    "media_id" uuid,
    "chilli_cut_price" numeric not null default '0'::numeric,
    "large_cut_price" numeric not null default '0'::numeric,
    "medium_cut_price" numeric not null default '0'::numeric,
    "small_cut_price" numeric not null default '0'::numeric,
    "head_price" numeric not null default '0'::numeric,
    "cleaned_with_head_price" numeric not null default '0'::numeric,
    "cleaned_without_head_price" numeric not null default '0'::numeric,
    "uncleaned_with_head_price" numeric not null default '0'::numeric,
    "uncleaned_without_head_price" numeric not null default '0'::numeric,
    "uses_cut_fish_price" boolean not null default true,
    "uses_whole_fish_price" boolean not null default false,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."fishes" enable row level security;

create table "public"."media" (
    "id" uuid not null default gen_random_uuid(),
    "object_id" uuid not null,
    "src" text not null,
    "alt" text default '''''::text'::text,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."media" enable row level security;

create table "public"."order_details" (
    "id" uuid not null default gen_random_uuid(),
    "price" numeric not null default 0.00,
    "metric" metric not null default 'kg'::metric,
    "weight" numeric not null default 0.00,
    "fish_id" uuid not null,
    "order_id" uuid not null,
    "price_type" price_type not null default 'medium_cut'::price_type,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."order_details" enable row level security;

create table "public"."orders" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "address" jsonb not null,
    "total" numeric not null,
    "coupon_discount" numeric not null default 0.00,
    "code" text not null,
    "is_paid" boolean not null default false,
    "comments" text not null,
    "delivering_on" timestamp with time zone,
    "status" order_status not null default 'pending'::order_status,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."orders" enable row level security;

create table "public"."profiles" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "name" text not null,
    "email" text not null,
    "role" user_role not null default 'user'::user_role,
    "mobile" text not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."profiles" enable row level security;

create table "public"."reviews" (
    "id" uuid not null default gen_random_uuid(),
    "name" text not null,
    "description" text not null,
    "rating" numeric not null,
    "media_id" uuid,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."reviews" enable row level security;

CREATE UNIQUE INDEX addresses_pkey ON public.addresses USING btree (id);

CREATE UNIQUE INDEX cart_items_pkey ON public.cart_items USING btree (id);

CREATE UNIQUE INDEX categories_fishes_pkey ON public.categories_fishes USING btree (category_id, fish_id);

CREATE UNIQUE INDEX categories_pkey ON public.categories USING btree (id);

CREATE UNIQUE INDEX fishes_pkey ON public.fishes USING btree (id);

CREATE UNIQUE INDEX media_pkey ON public.media USING btree (id);

CREATE UNIQUE INDEX order_details_pkey ON public.order_details USING btree (id);

CREATE UNIQUE INDEX orders_pkey ON public.orders USING btree (id);

CREATE UNIQUE INDEX profiles_pkey ON public.profiles USING btree (id);

CREATE UNIQUE INDEX reviews_pkey ON public.reviews USING btree (id);

alter table "public"."addresses" add constraint "addresses_pkey" PRIMARY KEY using index "addresses_pkey";

alter table "public"."cart_items" add constraint "cart_items_pkey" PRIMARY KEY using index "cart_items_pkey";

alter table "public"."categories" add constraint "categories_pkey" PRIMARY KEY using index "categories_pkey";

alter table "public"."categories_fishes" add constraint "categories_fishes_pkey" PRIMARY KEY using index "categories_fishes_pkey";

alter table "public"."fishes" add constraint "fishes_pkey" PRIMARY KEY using index "fishes_pkey";

alter table "public"."media" add constraint "media_pkey" PRIMARY KEY using index "media_pkey";

alter table "public"."order_details" add constraint "order_details_pkey" PRIMARY KEY using index "order_details_pkey";

alter table "public"."orders" add constraint "orders_pkey" PRIMARY KEY using index "orders_pkey";

alter table "public"."profiles" add constraint "profiles_pkey" PRIMARY KEY using index "profiles_pkey";

alter table "public"."reviews" add constraint "reviews_pkey" PRIMARY KEY using index "reviews_pkey";

alter table "public"."addresses" add constraint "addresses_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."addresses" validate constraint "addresses_user_id_fkey";

alter table "public"."cart_items" add constraint "cart_items_fish_id_fkey" FOREIGN KEY (fish_id) REFERENCES fishes(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."cart_items" validate constraint "cart_items_fish_id_fkey";

alter table "public"."cart_items" add constraint "cart_items_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."cart_items" validate constraint "cart_items_user_id_fkey";

alter table "public"."categories" add constraint "categories_media_id_fkey" FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE SET NULL not valid;

alter table "public"."categories" validate constraint "categories_media_id_fkey";

alter table "public"."categories_fishes" add constraint "categories_fishes_category_id_fkey" FOREIGN KEY (category_id) REFERENCES categories(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."categories_fishes" validate constraint "categories_fishes_category_id_fkey";

alter table "public"."categories_fishes" add constraint "categories_fishes_fish_id_fkey" FOREIGN KEY (fish_id) REFERENCES fishes(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."categories_fishes" validate constraint "categories_fishes_fish_id_fkey";

alter table "public"."fishes" add constraint "fishes_media_id_fkey" FOREIGN KEY (media_id) REFERENCES media(id) not valid;

alter table "public"."fishes" validate constraint "fishes_media_id_fkey";

alter table "public"."media" add constraint "media_object_id_fkey" FOREIGN KEY (object_id) REFERENCES storage.objects(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."media" validate constraint "media_object_id_fkey";

alter table "public"."order_details" add constraint "order_details_fish_id_fkey" FOREIGN KEY (fish_id) REFERENCES fishes(id) ON UPDATE CASCADE ON DELETE SET NULL not valid;

alter table "public"."order_details" validate constraint "order_details_fish_id_fkey";

alter table "public"."order_details" add constraint "order_details_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."order_details" validate constraint "order_details_order_id_fkey";

alter table "public"."orders" add constraint "orders_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."orders" validate constraint "orders_user_id_fkey";

alter table "public"."profiles" add constraint "profiles_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."profiles" validate constraint "profiles_user_id_fkey";

alter table "public"."reviews" add constraint "reviews_media_id_fkey" FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE SET NULL not valid;

alter table "public"."reviews" validate constraint "reviews_media_id_fkey";

grant delete on table "public"."addresses" to "anon";

grant insert on table "public"."addresses" to "anon";

grant references on table "public"."addresses" to "anon";

grant select on table "public"."addresses" to "anon";

grant trigger on table "public"."addresses" to "anon";

grant truncate on table "public"."addresses" to "anon";

grant update on table "public"."addresses" to "anon";

grant delete on table "public"."addresses" to "authenticated";

grant insert on table "public"."addresses" to "authenticated";

grant references on table "public"."addresses" to "authenticated";

grant select on table "public"."addresses" to "authenticated";

grant trigger on table "public"."addresses" to "authenticated";

grant truncate on table "public"."addresses" to "authenticated";

grant update on table "public"."addresses" to "authenticated";

grant delete on table "public"."addresses" to "postgres";

grant insert on table "public"."addresses" to "postgres";

grant references on table "public"."addresses" to "postgres";

grant select on table "public"."addresses" to "postgres";

grant trigger on table "public"."addresses" to "postgres";

grant truncate on table "public"."addresses" to "postgres";

grant update on table "public"."addresses" to "postgres";

grant delete on table "public"."addresses" to "service_role";

grant insert on table "public"."addresses" to "service_role";

grant references on table "public"."addresses" to "service_role";

grant select on table "public"."addresses" to "service_role";

grant trigger on table "public"."addresses" to "service_role";

grant truncate on table "public"."addresses" to "service_role";

grant update on table "public"."addresses" to "service_role";

grant delete on table "public"."cart_items" to "anon";

grant insert on table "public"."cart_items" to "anon";

grant references on table "public"."cart_items" to "anon";

grant select on table "public"."cart_items" to "anon";

grant trigger on table "public"."cart_items" to "anon";

grant truncate on table "public"."cart_items" to "anon";

grant update on table "public"."cart_items" to "anon";

grant delete on table "public"."cart_items" to "authenticated";

grant insert on table "public"."cart_items" to "authenticated";

grant references on table "public"."cart_items" to "authenticated";

grant select on table "public"."cart_items" to "authenticated";

grant trigger on table "public"."cart_items" to "authenticated";

grant truncate on table "public"."cart_items" to "authenticated";

grant update on table "public"."cart_items" to "authenticated";

grant delete on table "public"."cart_items" to "postgres";

grant insert on table "public"."cart_items" to "postgres";

grant references on table "public"."cart_items" to "postgres";

grant select on table "public"."cart_items" to "postgres";

grant trigger on table "public"."cart_items" to "postgres";

grant truncate on table "public"."cart_items" to "postgres";

grant update on table "public"."cart_items" to "postgres";

grant delete on table "public"."cart_items" to "service_role";

grant insert on table "public"."cart_items" to "service_role";

grant references on table "public"."cart_items" to "service_role";

grant select on table "public"."cart_items" to "service_role";

grant trigger on table "public"."cart_items" to "service_role";

grant truncate on table "public"."cart_items" to "service_role";

grant update on table "public"."cart_items" to "service_role";

grant delete on table "public"."categories" to "anon";

grant insert on table "public"."categories" to "anon";

grant references on table "public"."categories" to "anon";

grant select on table "public"."categories" to "anon";

grant trigger on table "public"."categories" to "anon";

grant truncate on table "public"."categories" to "anon";

grant update on table "public"."categories" to "anon";

grant delete on table "public"."categories" to "authenticated";

grant insert on table "public"."categories" to "authenticated";

grant references on table "public"."categories" to "authenticated";

grant select on table "public"."categories" to "authenticated";

grant trigger on table "public"."categories" to "authenticated";

grant truncate on table "public"."categories" to "authenticated";

grant update on table "public"."categories" to "authenticated";

grant delete on table "public"."categories" to "postgres";

grant insert on table "public"."categories" to "postgres";

grant references on table "public"."categories" to "postgres";

grant select on table "public"."categories" to "postgres";

grant trigger on table "public"."categories" to "postgres";

grant truncate on table "public"."categories" to "postgres";

grant update on table "public"."categories" to "postgres";

grant delete on table "public"."categories" to "service_role";

grant insert on table "public"."categories" to "service_role";

grant references on table "public"."categories" to "service_role";

grant select on table "public"."categories" to "service_role";

grant trigger on table "public"."categories" to "service_role";

grant truncate on table "public"."categories" to "service_role";

grant update on table "public"."categories" to "service_role";

grant delete on table "public"."categories_fishes" to "anon";

grant insert on table "public"."categories_fishes" to "anon";

grant references on table "public"."categories_fishes" to "anon";

grant select on table "public"."categories_fishes" to "anon";

grant trigger on table "public"."categories_fishes" to "anon";

grant truncate on table "public"."categories_fishes" to "anon";

grant update on table "public"."categories_fishes" to "anon";

grant delete on table "public"."categories_fishes" to "authenticated";

grant insert on table "public"."categories_fishes" to "authenticated";

grant references on table "public"."categories_fishes" to "authenticated";

grant select on table "public"."categories_fishes" to "authenticated";

grant trigger on table "public"."categories_fishes" to "authenticated";

grant truncate on table "public"."categories_fishes" to "authenticated";

grant update on table "public"."categories_fishes" to "authenticated";

grant delete on table "public"."categories_fishes" to "postgres";

grant insert on table "public"."categories_fishes" to "postgres";

grant references on table "public"."categories_fishes" to "postgres";

grant select on table "public"."categories_fishes" to "postgres";

grant trigger on table "public"."categories_fishes" to "postgres";

grant truncate on table "public"."categories_fishes" to "postgres";

grant update on table "public"."categories_fishes" to "postgres";

grant delete on table "public"."categories_fishes" to "service_role";

grant insert on table "public"."categories_fishes" to "service_role";

grant references on table "public"."categories_fishes" to "service_role";

grant select on table "public"."categories_fishes" to "service_role";

grant trigger on table "public"."categories_fishes" to "service_role";

grant truncate on table "public"."categories_fishes" to "service_role";

grant update on table "public"."categories_fishes" to "service_role";

grant delete on table "public"."fishes" to "anon";

grant insert on table "public"."fishes" to "anon";

grant references on table "public"."fishes" to "anon";

grant select on table "public"."fishes" to "anon";

grant trigger on table "public"."fishes" to "anon";

grant truncate on table "public"."fishes" to "anon";

grant update on table "public"."fishes" to "anon";

grant delete on table "public"."fishes" to "authenticated";

grant insert on table "public"."fishes" to "authenticated";

grant references on table "public"."fishes" to "authenticated";

grant select on table "public"."fishes" to "authenticated";

grant trigger on table "public"."fishes" to "authenticated";

grant truncate on table "public"."fishes" to "authenticated";

grant update on table "public"."fishes" to "authenticated";

grant delete on table "public"."fishes" to "postgres";

grant insert on table "public"."fishes" to "postgres";

grant references on table "public"."fishes" to "postgres";

grant select on table "public"."fishes" to "postgres";

grant trigger on table "public"."fishes" to "postgres";

grant truncate on table "public"."fishes" to "postgres";

grant update on table "public"."fishes" to "postgres";

grant delete on table "public"."fishes" to "service_role";

grant insert on table "public"."fishes" to "service_role";

grant references on table "public"."fishes" to "service_role";

grant select on table "public"."fishes" to "service_role";

grant trigger on table "public"."fishes" to "service_role";

grant truncate on table "public"."fishes" to "service_role";

grant update on table "public"."fishes" to "service_role";

grant delete on table "public"."media" to "anon";

grant insert on table "public"."media" to "anon";

grant references on table "public"."media" to "anon";

grant select on table "public"."media" to "anon";

grant trigger on table "public"."media" to "anon";

grant truncate on table "public"."media" to "anon";

grant update on table "public"."media" to "anon";

grant delete on table "public"."media" to "authenticated";

grant insert on table "public"."media" to "authenticated";

grant references on table "public"."media" to "authenticated";

grant select on table "public"."media" to "authenticated";

grant trigger on table "public"."media" to "authenticated";

grant truncate on table "public"."media" to "authenticated";

grant update on table "public"."media" to "authenticated";

grant delete on table "public"."media" to "postgres";

grant insert on table "public"."media" to "postgres";

grant references on table "public"."media" to "postgres";

grant select on table "public"."media" to "postgres";

grant trigger on table "public"."media" to "postgres";

grant truncate on table "public"."media" to "postgres";

grant update on table "public"."media" to "postgres";

grant delete on table "public"."media" to "service_role";

grant insert on table "public"."media" to "service_role";

grant references on table "public"."media" to "service_role";

grant select on table "public"."media" to "service_role";

grant trigger on table "public"."media" to "service_role";

grant truncate on table "public"."media" to "service_role";

grant update on table "public"."media" to "service_role";

grant delete on table "public"."order_details" to "anon";

grant insert on table "public"."order_details" to "anon";

grant references on table "public"."order_details" to "anon";

grant select on table "public"."order_details" to "anon";

grant trigger on table "public"."order_details" to "anon";

grant truncate on table "public"."order_details" to "anon";

grant update on table "public"."order_details" to "anon";

grant delete on table "public"."order_details" to "authenticated";

grant insert on table "public"."order_details" to "authenticated";

grant references on table "public"."order_details" to "authenticated";

grant select on table "public"."order_details" to "authenticated";

grant trigger on table "public"."order_details" to "authenticated";

grant truncate on table "public"."order_details" to "authenticated";

grant update on table "public"."order_details" to "authenticated";

grant delete on table "public"."order_details" to "postgres";

grant insert on table "public"."order_details" to "postgres";

grant references on table "public"."order_details" to "postgres";

grant select on table "public"."order_details" to "postgres";

grant trigger on table "public"."order_details" to "postgres";

grant truncate on table "public"."order_details" to "postgres";

grant update on table "public"."order_details" to "postgres";

grant delete on table "public"."order_details" to "service_role";

grant insert on table "public"."order_details" to "service_role";

grant references on table "public"."order_details" to "service_role";

grant select on table "public"."order_details" to "service_role";

grant trigger on table "public"."order_details" to "service_role";

grant truncate on table "public"."order_details" to "service_role";

grant update on table "public"."order_details" to "service_role";

grant delete on table "public"."orders" to "anon";

grant insert on table "public"."orders" to "anon";

grant references on table "public"."orders" to "anon";

grant select on table "public"."orders" to "anon";

grant trigger on table "public"."orders" to "anon";

grant truncate on table "public"."orders" to "anon";

grant update on table "public"."orders" to "anon";

grant delete on table "public"."orders" to "authenticated";

grant insert on table "public"."orders" to "authenticated";

grant references on table "public"."orders" to "authenticated";

grant select on table "public"."orders" to "authenticated";

grant trigger on table "public"."orders" to "authenticated";

grant truncate on table "public"."orders" to "authenticated";

grant update on table "public"."orders" to "authenticated";

grant delete on table "public"."orders" to "postgres";

grant insert on table "public"."orders" to "postgres";

grant references on table "public"."orders" to "postgres";

grant select on table "public"."orders" to "postgres";

grant trigger on table "public"."orders" to "postgres";

grant truncate on table "public"."orders" to "postgres";

grant update on table "public"."orders" to "postgres";

grant delete on table "public"."orders" to "service_role";

grant insert on table "public"."orders" to "service_role";

grant references on table "public"."orders" to "service_role";

grant select on table "public"."orders" to "service_role";

grant trigger on table "public"."orders" to "service_role";

grant truncate on table "public"."orders" to "service_role";

grant update on table "public"."orders" to "service_role";

grant delete on table "public"."profiles" to "anon";

grant insert on table "public"."profiles" to "anon";

grant references on table "public"."profiles" to "anon";

grant select on table "public"."profiles" to "anon";

grant trigger on table "public"."profiles" to "anon";

grant truncate on table "public"."profiles" to "anon";

grant update on table "public"."profiles" to "anon";

grant delete on table "public"."profiles" to "authenticated";

grant insert on table "public"."profiles" to "authenticated";

grant references on table "public"."profiles" to "authenticated";

grant select on table "public"."profiles" to "authenticated";

grant trigger on table "public"."profiles" to "authenticated";

grant truncate on table "public"."profiles" to "authenticated";

grant update on table "public"."profiles" to "authenticated";

grant delete on table "public"."profiles" to "postgres";

grant insert on table "public"."profiles" to "postgres";

grant references on table "public"."profiles" to "postgres";

grant select on table "public"."profiles" to "postgres";

grant trigger on table "public"."profiles" to "postgres";

grant truncate on table "public"."profiles" to "postgres";

grant update on table "public"."profiles" to "postgres";

grant delete on table "public"."profiles" to "service_role";

grant insert on table "public"."profiles" to "service_role";

grant references on table "public"."profiles" to "service_role";

grant select on table "public"."profiles" to "service_role";

grant trigger on table "public"."profiles" to "service_role";

grant truncate on table "public"."profiles" to "service_role";

grant update on table "public"."profiles" to "service_role";

grant delete on table "public"."reviews" to "anon";

grant insert on table "public"."reviews" to "anon";

grant references on table "public"."reviews" to "anon";

grant select on table "public"."reviews" to "anon";

grant trigger on table "public"."reviews" to "anon";

grant truncate on table "public"."reviews" to "anon";

grant update on table "public"."reviews" to "anon";

grant delete on table "public"."reviews" to "authenticated";

grant insert on table "public"."reviews" to "authenticated";

grant references on table "public"."reviews" to "authenticated";

grant select on table "public"."reviews" to "authenticated";

grant trigger on table "public"."reviews" to "authenticated";

grant truncate on table "public"."reviews" to "authenticated";

grant update on table "public"."reviews" to "authenticated";

grant delete on table "public"."reviews" to "postgres";

grant insert on table "public"."reviews" to "postgres";

grant references on table "public"."reviews" to "postgres";

grant select on table "public"."reviews" to "postgres";

grant trigger on table "public"."reviews" to "postgres";

grant truncate on table "public"."reviews" to "postgres";

grant update on table "public"."reviews" to "postgres";

grant delete on table "public"."reviews" to "service_role";

grant insert on table "public"."reviews" to "service_role";

grant references on table "public"."reviews" to "service_role";

grant select on table "public"."reviews" to "service_role";

grant trigger on table "public"."reviews" to "service_role";

grant truncate on table "public"."reviews" to "service_role";

grant update on table "public"."reviews" to "service_role";

create policy "Enable delete for authenticated users"
on "public"."addresses"
as permissive
for delete
to authenticated
using (((auth.uid() = user_id) AND (((auth.jwt() ->> 'is_anonymous'::text))::boolean IS FALSE)));


create policy "Enable insert for authenticated users only"
on "public"."addresses"
as permissive
for insert
to authenticated
with check (((auth.uid() = user_id) AND (((auth.jwt() ->> 'is_anonymous'::text))::boolean IS FALSE)));


create policy "Enable read access for authorized users"
on "public"."addresses"
as permissive
for select
to authenticated
using (((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))) OR ((auth.uid() = user_id) AND (((auth.jwt() ->> 'is_anonymous'::text))::boolean IS FALSE))));


create policy "Enable update for authenticated users"
on "public"."addresses"
as permissive
for update
to authenticated
using (((auth.uid() = user_id) AND (((auth.jwt() ->> 'is_anonymous'::text))::boolean IS FALSE)));


create policy "Enable all access to authorized users"
on "public"."cart_items"
as permissive
for all
to authenticated
using (((auth.uid() = user_id) OR (auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role)))));


create policy "Enable delete for admins"
on "public"."categories"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."categories"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."categories"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."categories"
as permissive
for update
to public
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."categories_fishes"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."categories_fishes"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."categories_fishes"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."categories_fishes"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."fishes"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for authenticated users"
on "public"."fishes"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."fishes"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."fishes"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."media"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."media"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."media"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."media"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."order_details"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for authorized users only"
on "public"."order_details"
as permissive
for insert
to authenticated
with check (((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))) OR ((auth.uid() IN ( SELECT orders.user_id
   FROM orders
  WHERE (orders.id = order_details.order_id))) AND (((auth.jwt() ->> 'is_anonymous'::text))::boolean IS FALSE))));


create policy "Enable read access for authorized users"
on "public"."order_details"
as permissive
for select
to authenticated
using (((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))) OR ((auth.uid() IN ( SELECT orders.user_id
   FROM orders
  WHERE (orders.id = order_details.order_id))) AND (((auth.jwt() ->> 'is_anonymous'::text))::boolean IS FALSE))));


create policy "Enable update for admins"
on "public"."order_details"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."orders"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for authorized users only"
on "public"."orders"
as permissive
for insert
to authenticated
with check (((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))) OR ((auth.uid() = user_id) AND (((auth.jwt() ->> 'is_anonymous'::text))::boolean IS FALSE))));


create policy "Enable read access for authorized users"
on "public"."orders"
as permissive
for select
to authenticated
using (((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))) OR ((auth.uid() = user_id) AND (((auth.jwt() ->> 'is_anonymous'::text))::boolean IS FALSE))));


create policy "Enable update for admins"
on "public"."orders"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for authenticated users"
on "public"."profiles"
as permissive
for delete
to authenticated
using (((auth.uid() = user_id) AND (((auth.jwt() ->> 'is_anonymous'::text))::boolean IS FALSE)));


create policy "Enable insert for authenticated users"
on "public"."profiles"
as permissive
for insert
to public
with check (true);


create policy "Enable read access for all users"
on "public"."profiles"
as permissive
for select
to public
using (true);


create policy "Enable update for authenticated users"
on "public"."profiles"
as permissive
for update
to authenticated
using (((auth.uid() = user_id) AND (((auth.jwt() ->> 'is_anonymous'::text))::boolean IS FALSE)));


create policy "Enable delete for admins"
on "public"."reviews"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."reviews"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."reviews"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."reviews"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));



