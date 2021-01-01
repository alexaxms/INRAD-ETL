CREATE TABLE "user_dimension" (
  "id" SERIAL PRIMARY KEY,
  "full_name" varchar,
  "role" varchar
);

CREATE TABLE "medical_fact" (
  "id" SERIAL PRIMARY KEY,
  "date" date,
  "summary" varchar,
  "type" varchar,
  "user_id" int,
  "treament_id" int,
  "disease_id" int,
  "patient_id" int,
  "disease_stage_id" int
);

CREATE TABLE "treatment_dimension" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "start_date" date,
  "end_date" date,
  "success" boolean
);

CREATE TABLE "disease_dimension" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "type" varchar
);

CREATE TABLE "disease_stage_dimension" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "stage" varchar
);

CREATE TABLE "patient_attachments_dimension" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "description" varchar,
  "url" varchar,
  "patient_id" int
);

CREATE TABLE "images_dimension" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "description" varchar,
  "url" varchar,
  "medical_fact_id" int
);

CREATE TABLE "patient_dimension" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "last_name" varchar,
  "phone_number" varchar,
  "identifier" varchar,
  "age" int,
  "gender" varchar,
  "blood_type" varchar,
  "start_treatment_date" date,
  "preexistant_diagnostic" boolean
);

CREATE TABLE "diagnostic_dimension" (
  "id" SERIAL PRIMARY KEY,
  "medical_fact_id" int,
  "symptom_id" int
);

CREATE TABLE "symptom_dimension" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "group" varchar
);

ALTER TABLE "patient_attachments_dimension" ADD FOREIGN KEY ("patient_id") REFERENCES "patient_dimension" ("id");

ALTER TABLE "medical_fact" ADD FOREIGN KEY ("user_id") REFERENCES "user_dimension" ("id");

ALTER TABLE "medical_fact" ADD FOREIGN KEY ("treament_id") REFERENCES "treatment_dimension" ("id");

ALTER TABLE "medical_fact" ADD FOREIGN KEY ("disease_id") REFERENCES "disease_dimension" ("id");

ALTER TABLE "medical_fact" ADD FOREIGN KEY ("patient_id") REFERENCES "patient_dimension" ("id");

ALTER TABLE "medical_fact" ADD FOREIGN KEY ("disease_stage_id") REFERENCES "disease_stage_dimension" ("id");

ALTER TABLE "images_dimension" ADD FOREIGN KEY ("medical_fact_id") REFERENCES "medical_fact" ("id");

ALTER TABLE "diagnostic_dimension" ADD FOREIGN KEY ("symptom_id") REFERENCES "symptom_dimension" ("id");

ALTER TABLE "diagnostic_dimension" ADD FOREIGN KEY ("medical_fact_id") REFERENCES "medical_fact" ("id");
