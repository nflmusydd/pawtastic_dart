-- ==============================================================
-- CREATE BASE FUNCTIONS 2
-- 
-- Deskripsi: Fungsi untuk trim spasi di awal/akhir untuk TEXT
--            dan melakukan UPPERCASE LOWERCASE di kolom tertentu
-- ===============================================================

CREATE OR REPLACE FUNCTION public.uppercase_fields()
RETURNS TRIGGER AS $$
DECLARE
  col TEXT;
  rec_json JSONB;
BEGIN
  rec_json := to_jsonb(NEW);
  FOR i IN 0..TG_NARGS - 1 LOOP
    col := TG_ARGV[i];
    IF rec_json ? col THEN
      rec_json := rec_json || jsonb_build_object(col, UPPER(rec_json->>col));
    END IF;
  END LOOP;
  NEW := jsonb_populate_record(NEW, rec_json);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION public.lowercase_fields()
RETURNS TRIGGER AS $$
DECLARE
    col TEXT;
    rec_json JSONB;
BEGIN
    rec_json := to_jsonb(NEW);
    FOR i IN 0..TG_NARGS - 1 LOOP
        col := TG_ARGV[i];
        IF rec_json ? col THEN
            rec_json := rec_json || jsonb_build_object(col, LOWER(rec_json->>col));
        END IF;
    END LOOP;
    NEW := jsonb_populate_record(NEW, rec_json);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.normalize_case_fields()
RETURNS TRIGGER AS $$
DECLARE
    arg TEXT;
    col TEXT;
    rec_json JSONB;
BEGIN
    rec_json := to_jsonb(NEW);

    FOR i IN 0..TG_NARGS - 1 LOOP
        arg := TG_ARGV[i];

        IF arg LIKE 'upper:%' THEN
            col := substring(arg FROM 7);
            rec_json := rec_json || jsonb_build_object(
                col,
                UPPER(rec_json->>col)
            );

        ELSIF arg LIKE 'lower:%' THEN
            col := substring(arg FROM 7);
            rec_json := rec_json || jsonb_build_object(
                col,
                LOWER(rec_json->>col)
            );
        END IF;
    END LOOP;

    NEW := jsonb_populate_record(NEW, rec_json);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION public.trim_text_fields()
RETURNS TRIGGER AS $$
DECLARE
    column_name TEXT;
    rec_json JSONB;
BEGIN
    rec_json := to_jsonb(NEW);
    FOR column_name IN
        SELECT col.column_name
        FROM information_schema.columns col
        WHERE col.table_schema = TG_TABLE_SCHEMA
            AND col.table_name = TG_TABLE_NAME
            AND col.data_type = 'text'
        LOOP
            IF rec_json ? column_name AND rec_json->>column_name IS NOT NULL THEN
                rec_json := rec_json || jsonb_build_object(column_name, trim(rec_json->>column_name));
            END IF;
        END LOOP;
    NEW := jsonb_populate_record(NEW, rec_json);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
