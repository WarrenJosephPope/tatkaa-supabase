alter table "public"."fishes" drop constraint "fishes_media_id_fkey";

create table "public"."fish_gallery" (
    "created_at" timestamp with time zone not null default now(),
    "fish_id" uuid not null,
    "media_id" uuid not null
);


alter table "public"."fish_gallery" enable row level security;

alter table "public"."fishes" drop column "media_id";

CREATE UNIQUE INDEX fish_gallery_pkey ON public.fish_gallery USING btree (fish_id, media_id);

alter table "public"."fish_gallery" add constraint "fish_gallery_pkey" PRIMARY KEY using index "fish_gallery_pkey";

alter table "public"."fish_gallery" add constraint "fish_gallery_fish_id_fkey" FOREIGN KEY (fish_id) REFERENCES fishes(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."fish_gallery" validate constraint "fish_gallery_fish_id_fkey";

alter table "public"."fish_gallery" add constraint "fish_gallery_media_id_fkey" FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."fish_gallery" validate constraint "fish_gallery_media_id_fkey";

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

grant delete on table "public"."fish_gallery" to "anon";

grant insert on table "public"."fish_gallery" to "anon";

grant references on table "public"."fish_gallery" to "anon";

grant select on table "public"."fish_gallery" to "anon";

grant trigger on table "public"."fish_gallery" to "anon";

grant truncate on table "public"."fish_gallery" to "anon";

grant update on table "public"."fish_gallery" to "anon";

grant delete on table "public"."fish_gallery" to "authenticated";

grant insert on table "public"."fish_gallery" to "authenticated";

grant references on table "public"."fish_gallery" to "authenticated";

grant select on table "public"."fish_gallery" to "authenticated";

grant trigger on table "public"."fish_gallery" to "authenticated";

grant truncate on table "public"."fish_gallery" to "authenticated";

grant update on table "public"."fish_gallery" to "authenticated";

grant delete on table "public"."fish_gallery" to "postgres";

grant insert on table "public"."fish_gallery" to "postgres";

grant references on table "public"."fish_gallery" to "postgres";

grant select on table "public"."fish_gallery" to "postgres";

grant trigger on table "public"."fish_gallery" to "postgres";

grant truncate on table "public"."fish_gallery" to "postgres";

grant update on table "public"."fish_gallery" to "postgres";

grant delete on table "public"."fish_gallery" to "service_role";

grant insert on table "public"."fish_gallery" to "service_role";

grant references on table "public"."fish_gallery" to "service_role";

grant select on table "public"."fish_gallery" to "service_role";

grant trigger on table "public"."fish_gallery" to "service_role";

grant truncate on table "public"."fish_gallery" to "service_role";

grant update on table "public"."fish_gallery" to "service_role";

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

create policy "Enable delete for authenticated users"
on "public"."fish_gallery"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for authenticated users only"
on "public"."fish_gallery"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."fish_gallery"
as permissive
for select
to public
using (true);


create policy "Enable update for authenticated users"
on "public"."fish_gallery"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));



