alter table "public"."static_pages" add column "published" boolean not null default true;

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

grant delete on table "public"."static_pages" to "postgres";

grant insert on table "public"."static_pages" to "postgres";

grant references on table "public"."static_pages" to "postgres";

grant select on table "public"."static_pages" to "postgres";

grant trigger on table "public"."static_pages" to "postgres";

grant truncate on table "public"."static_pages" to "postgres";

grant update on table "public"."static_pages" to "postgres";

create policy "Enable delete for admins"
on "public"."static_pages"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."static_pages"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."static_pages"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."static_pages"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));



