{% macro extract_uuid(column) %}
REGEXP_REPLACE({{column}},'(.*)(\w{8}\-\w{4}\-\w{4}\-\w{4}\-\w{12})(.*)','\2','i')
{% endmacro %}