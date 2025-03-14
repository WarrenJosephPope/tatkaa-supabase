create table "public"."static_pages" (
    "id" uuid not null default gen_random_uuid(),
    "slug" text not null,
    "title" text not null,
    "meta_description" text,
    "content" text,
    "meta_keywords" text,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."static_pages" enable row level security;

CREATE UNIQUE INDEX static_pages_pkey ON public.static_pages USING btree (id);

CREATE UNIQUE INDEX static_pages_slug_key ON public.static_pages USING btree (slug);

alter table "public"."static_pages" add constraint "static_pages_pkey" PRIMARY KEY using index "static_pages_pkey";

alter table "public"."static_pages" add constraint "static_pages_slug_key" UNIQUE using index "static_pages_slug_key";

grant delete on table "public"."addresses" to "postgres";

grant insert on table "public"."addresses" to "postgres";

grant references on table "public"."addresses" to "postgres";

grant select on table "public"."addresses" to "postgres";

grant trigger on table "public"."addresses" to "postgres";

grant truncate on table "public"."addresses" to "postgres";

grant update on table "public"."addresses" to "postgres";

grant delete on table "public"."cart_items" to "postgres";

grant insert on table "public"."cart_items" to "postgres";

grant references on table "public"."cart_items" to "postgres";

grant select on table "public"."cart_items" to "postgres";

grant trigger on table "public"."cart_items" to "postgres";

grant truncate on table "public"."cart_items" to "postgres";

grant update on table "public"."cart_items" to "postgres";

grant delete on table "public"."categories" to "postgres";

grant insert on table "public"."categories" to "postgres";

grant references on table "public"."categories" to "postgres";

grant select on table "public"."categories" to "postgres";

grant trigger on table "public"."categories" to "postgres";

grant truncate on table "public"."categories" to "postgres";

grant update on table "public"."categories" to "postgres";

grant delete on table "public"."categories_meat" to "postgres";

grant insert on table "public"."categories_meat" to "postgres";

grant references on table "public"."categories_meat" to "postgres";

grant select on table "public"."categories_meat" to "postgres";

grant trigger on table "public"."categories_meat" to "postgres";

grant truncate on table "public"."categories_meat" to "postgres";

grant update on table "public"."categories_meat" to "postgres";

grant delete on table "public"."meat_gallery" to "postgres";

grant insert on table "public"."meat_gallery" to "postgres";

grant references on table "public"."meat_gallery" to "postgres";

grant select on table "public"."meat_gallery" to "postgres";

grant trigger on table "public"."meat_gallery" to "postgres";

grant truncate on table "public"."meat_gallery" to "postgres";

grant update on table "public"."meat_gallery" to "postgres";

grant delete on table "public"."meat" to "postgres";

grant insert on table "public"."meat" to "postgres";

grant references on table "public"."meat" to "postgres";

grant select on table "public"."meat" to "postgres";

grant trigger on table "public"."meat" to "postgres";

grant truncate on table "public"."meat" to "postgres";

grant update on table "public"."meat" to "postgres";

grant delete on table "public"."media" to "postgres";

grant insert on table "public"."media" to "postgres";

grant references on table "public"."media" to "postgres";

grant select on table "public"."media" to "postgres";

grant trigger on table "public"."media" to "postgres";

grant truncate on table "public"."media" to "postgres";

grant update on table "public"."media" to "postgres";

grant delete on table "public"."order_details" to "postgres";

grant insert on table "public"."order_details" to "postgres";

grant references on table "public"."order_details" to "postgres";

grant select on table "public"."order_details" to "postgres";

grant trigger on table "public"."order_details" to "postgres";

grant truncate on table "public"."order_details" to "postgres";

grant update on table "public"."order_details" to "postgres";

grant delete on table "public"."orders" to "postgres";

grant insert on table "public"."orders" to "postgres";

grant references on table "public"."orders" to "postgres";

grant select on table "public"."orders" to "postgres";

grant trigger on table "public"."orders" to "postgres";

grant truncate on table "public"."orders" to "postgres";

grant update on table "public"."orders" to "postgres";

grant delete on table "public"."profiles" to "postgres";

grant insert on table "public"."profiles" to "postgres";

grant references on table "public"."profiles" to "postgres";

grant select on table "public"."profiles" to "postgres";

grant trigger on table "public"."profiles" to "postgres";

grant truncate on table "public"."profiles" to "postgres";

grant update on table "public"."profiles" to "postgres";

grant delete on table "public"."reviews" to "postgres";

grant insert on table "public"."reviews" to "postgres";

grant references on table "public"."reviews" to "postgres";

grant select on table "public"."reviews" to "postgres";

grant trigger on table "public"."reviews" to "postgres";

grant truncate on table "public"."reviews" to "postgres";

grant update on table "public"."reviews" to "postgres";

grant delete on table "public"."static_pages" to "anon";

grant insert on table "public"."static_pages" to "anon";

grant references on table "public"."static_pages" to "anon";

grant select on table "public"."static_pages" to "anon";

grant trigger on table "public"."static_pages" to "anon";

grant truncate on table "public"."static_pages" to "anon";

grant update on table "public"."static_pages" to "anon";

grant delete on table "public"."static_pages" to "authenticated";

grant insert on table "public"."static_pages" to "authenticated";

grant references on table "public"."static_pages" to "authenticated";

grant select on table "public"."static_pages" to "authenticated";

grant trigger on table "public"."static_pages" to "authenticated";

grant truncate on table "public"."static_pages" to "authenticated";

grant update on table "public"."static_pages" to "authenticated";

grant delete on table "public"."static_pages" to "postgres";

grant insert on table "public"."static_pages" to "postgres";

grant references on table "public"."static_pages" to "postgres";

grant select on table "public"."static_pages" to "postgres";

grant trigger on table "public"."static_pages" to "postgres";

grant truncate on table "public"."static_pages" to "postgres";

grant update on table "public"."static_pages" to "postgres";

grant delete on table "public"."static_pages" to "service_role";

grant insert on table "public"."static_pages" to "service_role";

grant references on table "public"."static_pages" to "service_role";

grant select on table "public"."static_pages" to "service_role";

grant trigger on table "public"."static_pages" to "service_role";

grant truncate on table "public"."static_pages" to "service_role";

grant update on table "public"."static_pages" to "service_role";


