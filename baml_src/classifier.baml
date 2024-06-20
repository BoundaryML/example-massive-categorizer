// Defining a data model.
enum Tools {
  // We'll define these in python
  @@dynamic

  @@alias(ToolCategory)
}

class Classification {
  category Tools
  reason string
}



// Creating a function to extract the resume from a string.
function Classify(tool: string, description: string, count: int) -> Classification[] {
  client FastOpenAI
  prompt #"
    Given tools and their descriptions, classify the tools into categories.
    {{ ctx.output_format(enum_value_prefix=null) }}

    {% if count > 1 %}
    Give me the {{ count }} best options.
    {% endif %}

    {{ _.role('user') }}
    Tool: {{ tool }}
    Description: {{ description }}
  "#
}
