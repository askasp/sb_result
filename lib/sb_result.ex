defmodule SbResult do
  defmacro left >>> right do
    quote do
      (fn ->
         case unquote(left) do
           {:ok, x} -> x |> unquote(right)
           :error -> {:error, "empty error"}
           {:error, _} = expr -> expr
         end
       end).()
    end
  end

  defmacro map(args, func) do
    quote do
      (fn ->
         unquote(args) |> unquote(func)
         |> case do
             nil -> {:error, "Was nil"}
             result -> {:ok, result}
             end
       end).()
    end
  end

  defmacro tee(args, func) do
    quote do
      (fn ->
         unquote(args) |> unquote(func)
         {:ok, unquote(args)}
       end).()
    end
  end

  defmacro try_catch(args, func) do
    quote do
      (fn ->
         try do
           {:ok, unquote(args) |> unquote(func)}
         rescue
           e -> {:error, e}
         end
       end).()
    end
  end
end
