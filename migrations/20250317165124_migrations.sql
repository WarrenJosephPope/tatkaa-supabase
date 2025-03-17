create table "public"."approved_pincodes" (
    "id" uuid not null default gen_random_uuid(),
    "pincode" text not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."approved_pincodes" enable row level security;

create table "public"."homepage_banner" (
    "media_id" uuid not null
);


alter table "public"."homepage_banner" enable row level security;

create table "public"."page_seo" (
    "id" uuid not null default gen_random_uuid(),
    "slug" text not null,
    "title" text not null,
    "description" text not null,
    "keywords" text not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."page_seo" enable row level security;

create table "public"."settings" (
    "id" uuid not null default gen_random_uuid(),
    "setting_key" text not null,
    "setting_value" text,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."settings" enable row level security;

alter table "public"."prices" add column "media_id" uuid;

CREATE UNIQUE INDEX approved_pincodes_pincode_key ON public.approved_pincodes USING btree (pincode);

CREATE UNIQUE INDEX approved_pincodes_pkey ON public.approved_pincodes USING btree (id);

CREATE UNIQUE INDEX homepage_banner_pkey ON public.homepage_banner USING btree (media_id);

CREATE UNIQUE INDEX page_seo_pkey ON public.page_seo USING btree (id);

CREATE UNIQUE INDEX page_seo_slug_key ON public.page_seo USING btree (slug);

CREATE UNIQUE INDEX settings_pkey ON public.settings USING btree (id);

CREATE UNIQUE INDEX settings_setting_key_key ON public.settings USING btree (setting_key);

alter table "public"."approved_pincodes" add constraint "approved_pincodes_pkey" PRIMARY KEY using index "approved_pincodes_pkey";

alter table "public"."homepage_banner" add constraint "homepage_banner_pkey" PRIMARY KEY using index "homepage_banner_pkey";

alter table "public"."page_seo" add constraint "page_seo_pkey" PRIMARY KEY using index "page_seo_pkey";

alter table "public"."settings" add constraint "settings_pkey" PRIMARY KEY using index "settings_pkey";

alter table "public"."approved_pincodes" add constraint "approved_pincodes_pincode_key" UNIQUE using index "approved_pincodes_pincode_key";

alter table "public"."homepage_banner" add constraint "homepage_banner_media_id_fkey" FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."homepage_banner" validate constraint "homepage_banner_media_id_fkey";

alter table "public"."page_seo" add constraint "page_seo_slug_key" UNIQUE using index "page_seo_slug_key";

alter table "public"."prices" add constraint "prices_media_id_fkey" FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE SET NULL not valid;

alter table "public"."prices" validate constraint "prices_media_id_fkey";

alter table "public"."settings" add constraint "settings_setting_key_key" UNIQUE using index "settings_setting_key_key";

grant delete on table "public"."approved_pincodes" to "anon";

grant insert on table "public"."approved_pincodes" to "anon";

grant references on table "public"."approved_pincodes" to "anon";

grant select on table "public"."approved_pincodes" to "anon";

grant trigger on table "public"."approved_pincodes" to "anon";

grant truncate on table "public"."approved_pincodes" to "anon";

grant update on table "public"."approved_pincodes" to "anon";

grant delete on table "public"."approved_pincodes" to "authenticated";

grant insert on table "public"."approved_pincodes" to "authenticated";

grant references on table "public"."approved_pincodes" to "authenticated";

grant select on table "public"."approved_pincodes" to "authenticated";

grant trigger on table "public"."approved_pincodes" to "authenticated";

grant truncate on table "public"."approved_pincodes" to "authenticated";

grant update on table "public"."approved_pincodes" to "authenticated";

grant delete on table "public"."approved_pincodes" to "postgres";

grant insert on table "public"."approved_pincodes" to "postgres";

grant references on table "public"."approved_pincodes" to "postgres";

grant select on table "public"."approved_pincodes" to "postgres";

grant trigger on table "public"."approved_pincodes" to "postgres";

grant truncate on table "public"."approved_pincodes" to "postgres";

grant update on table "public"."approved_pincodes" to "postgres";

grant delete on table "public"."approved_pincodes" to "service_role";

grant insert on table "public"."approved_pincodes" to "service_role";

grant references on table "public"."approved_pincodes" to "service_role";

grant select on table "public"."approved_pincodes" to "service_role";

grant trigger on table "public"."approved_pincodes" to "service_role";

grant truncate on table "public"."approved_pincodes" to "service_role";

grant update on table "public"."approved_pincodes" to "service_role";

grant delete on table "public"."homepage_banner" to "anon";

grant insert on table "public"."homepage_banner" to "anon";

grant references on table "public"."homepage_banner" to "anon";

grant select on table "public"."homepage_banner" to "anon";

grant trigger on table "public"."homepage_banner" to "anon";

grant truncate on table "public"."homepage_banner" to "anon";

grant update on table "public"."homepage_banner" to "anon";

grant delete on table "public"."homepage_banner" to "authenticated";

grant insert on table "public"."homepage_banner" to "authenticated";

grant references on table "public"."homepage_banner" to "authenticated";

grant select on table "public"."homepage_banner" to "authenticated";

grant trigger on table "public"."homepage_banner" to "authenticated";

grant truncate on table "public"."homepage_banner" to "authenticated";

grant update on table "public"."homepage_banner" to "authenticated";

grant delete on table "public"."homepage_banner" to "postgres";

grant insert on table "public"."homepage_banner" to "postgres";

grant references on table "public"."homepage_banner" to "postgres";

grant select on table "public"."homepage_banner" to "postgres";

grant trigger on table "public"."homepage_banner" to "postgres";

grant truncate on table "public"."homepage_banner" to "postgres";

grant update on table "public"."homepage_banner" to "postgres";

grant delete on table "public"."homepage_banner" to "service_role";

grant insert on table "public"."homepage_banner" to "service_role";

grant references on table "public"."homepage_banner" to "service_role";

grant select on table "public"."homepage_banner" to "service_role";

grant trigger on table "public"."homepage_banner" to "service_role";

grant truncate on table "public"."homepage_banner" to "service_role";

grant update on table "public"."homepage_banner" to "service_role";

grant delete on table "public"."page_seo" to "anon";

grant insert on table "public"."page_seo" to "anon";

grant references on table "public"."page_seo" to "anon";

grant select on table "public"."page_seo" to "anon";

grant trigger on table "public"."page_seo" to "anon";

grant truncate on table "public"."page_seo" to "anon";

grant update on table "public"."page_seo" to "anon";

grant delete on table "public"."page_seo" to "authenticated";

grant insert on table "public"."page_seo" to "authenticated";

grant references on table "public"."page_seo" to "authenticated";

grant select on table "public"."page_seo" to "authenticated";

grant trigger on table "public"."page_seo" to "authenticated";

grant truncate on table "public"."page_seo" to "authenticated";

grant update on table "public"."page_seo" to "authenticated";

grant delete on table "public"."page_seo" to "postgres";

grant insert on table "public"."page_seo" to "postgres";

grant references on table "public"."page_seo" to "postgres";

grant select on table "public"."page_seo" to "postgres";

grant trigger on table "public"."page_seo" to "postgres";

grant truncate on table "public"."page_seo" to "postgres";

grant update on table "public"."page_seo" to "postgres";

grant delete on table "public"."page_seo" to "service_role";

grant insert on table "public"."page_seo" to "service_role";

grant references on table "public"."page_seo" to "service_role";

grant select on table "public"."page_seo" to "service_role";

grant trigger on table "public"."page_seo" to "service_role";

grant truncate on table "public"."page_seo" to "service_role";

grant update on table "public"."page_seo" to "service_role";

grant delete on table "public"."settings" to "anon";

grant insert on table "public"."settings" to "anon";

grant references on table "public"."settings" to "anon";

grant select on table "public"."settings" to "anon";

grant trigger on table "public"."settings" to "anon";

grant truncate on table "public"."settings" to "anon";

grant update on table "public"."settings" to "anon";

grant delete on table "public"."settings" to "authenticated";

grant insert on table "public"."settings" to "authenticated";

grant references on table "public"."settings" to "authenticated";

grant select on table "public"."settings" to "authenticated";

grant trigger on table "public"."settings" to "authenticated";

grant truncate on table "public"."settings" to "authenticated";

grant update on table "public"."settings" to "authenticated";

grant delete on table "public"."settings" to "postgres";

grant insert on table "public"."settings" to "postgres";

grant references on table "public"."settings" to "postgres";

grant select on table "public"."settings" to "postgres";

grant trigger on table "public"."settings" to "postgres";

grant truncate on table "public"."settings" to "postgres";

grant update on table "public"."settings" to "postgres";

grant delete on table "public"."settings" to "service_role";

grant insert on table "public"."settings" to "service_role";

grant references on table "public"."settings" to "service_role";

grant select on table "public"."settings" to "service_role";

grant trigger on table "public"."settings" to "service_role";

grant truncate on table "public"."settings" to "service_role";

grant update on table "public"."settings" to "service_role";

create policy "Enable delete for admins"
on "public"."approved_pincodes"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."approved_pincodes"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."approved_pincodes"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."approved_pincodes"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."homepage_banner"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."homepage_banner"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."homepage_banner"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."homepage_banner"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."page_seo"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."page_seo"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."page_seo"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."page_seo"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable delete for admins"
on "public"."settings"
as permissive
for delete
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable insert for admins"
on "public"."settings"
as permissive
for insert
to authenticated
with check ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));


create policy "Enable read access for all users"
on "public"."settings"
as permissive
for select
to public
using (true);


create policy "Enable update for admins"
on "public"."settings"
as permissive
for update
to authenticated
using ((auth.uid() IN ( SELECT profiles.user_id
   FROM profiles
  WHERE (profiles.role = 'admin'::user_role))));



