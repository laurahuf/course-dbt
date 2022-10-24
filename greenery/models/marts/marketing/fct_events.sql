WITH

events AS (

    SELECT * FROM {{ ref('stg_postgres__events') }}
),

event_agg AS (

    {% set event_types = dbt_utils.get_column_values(table=ref('stg_postgres__events'), column='event_type') %}

    SELECT
        COUNT(DISTINCT event_session_uuid) AS total_unique_sessions
        {% for event_type in event_types %}
        , SUM(iff(event_type = '{{event_type}}', 1, 0)) AS total_{{event_type}}
        {% endfor %}
    
    FROM events
)

SELECT * FROM event_agg