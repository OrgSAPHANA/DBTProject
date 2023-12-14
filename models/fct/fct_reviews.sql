{{
    config(
      materialized = 'incremental',
      on_schema_change='fail'
      )
}}
WITH src_review AS (
  SELECT * FROM {{ ref('src_reviews') }}
)
SELECT * FROM src_review
WHERE REVIEW_TEXT is not null
{% if is_incremental() %}
  and REVIEW_DATE > (select max(REVIEW_DATE) from {{ this }})
{% endif %}