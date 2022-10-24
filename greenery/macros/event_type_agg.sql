{% macro event_type_agg(event_type) %}    
    {% set event_types = dbt_utils.get_column_values(table=ref('stg_postgres__events'), column='event_type') %}
    -- ["page_view", "add_to_cart", "package_shipped", "checkout"] %}

    SELECT
        {% for event_type in event_types %}
        , SUM(iff(event_type = '{{event_type}}', 1, 0)) AS total_{{event_type}}
        {% endfor %}

{% endmacro %}