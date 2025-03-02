alter table "public"."categories" alter column "slug" set not null;

alter table "public"."fishes" alter column "slug" set not null;

CREATE UNIQUE INDEX categories_slug_key ON public.categories USING btree (slug);

CREATE UNIQUE INDEX fishes_slug_key ON public.fishes USING btree (slug);

alter table "public"."categories" add constraint "categories_slug_key" UNIQUE using index "categories_slug_key";

alter table "public"."fishes" add constraint "fishes_slug_key" UNIQUE using index "fishes_slug_key";

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

grant delete on table "public"."categories_fishes" to "postgres";

grant insert on table "public"."categories_fishes" to "postgres";

grant references on table "public"."categories_fishes" to "postgres";

grant select on table "public"."categories_fishes" to "postgres";

grant trigger on table "public"."categories_fishes" to "postgres";

grant truncate on table "public"."categories_fishes" to "postgres";

grant update on table "public"."categories_fishes" to "postgres";

grant delete on table "public"."fish_gallery" to "postgres";

grant insert on table "public"."fish_gallery" to "postgres";

grant references on table "public"."fish_gallery" to "postgres";

grant select on table "public"."fish_gallery" to "postgres";

grant trigger on table "public"."fish_gallery" to "postgres";

grant truncate on table "public"."fish_gallery" to "postgres";

grant update on table "public"."fish_gallery" to "postgres";

grant delete on table "public"."fishes" to "postgres";

grant insert on table "public"."fishes" to "postgres";

grant references on table "public"."fishes" to "postgres";

grant select on table "public"."fishes" to "postgres";

grant trigger on table "public"."fishes" to "postgres";

grant truncate on table "public"."fishes" to "postgres";

grant update on table "public"."fishes" to "postgres";

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


