defmodule SbResult do
  defmacro left >>> right do
    quote do
      (fn ->
         case unquote(left) do
           {:ok, x} -> x |> unquote(right)
           {:error, _} = expr -> expr
           nil -> {:error, "Nil was returned"}
         end
       end).()
    end
  end

  defmacro map(args, func) do
    quote do
      (fn ->
         result = unquote(args) |> unquote(func)
         {:ok, result}
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
