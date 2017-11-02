%{
  configs: [
    %{
      name: "default",
      checks: [
        # For others you can also set parameters
        {Credo.Check.Readability.MaxLineLength, priority: :low, max_length: 90},
        # Disable @moduledoc
        {Credo.Check.Readability.ModuleDoc, false},
      ]
    }
  ]
}
