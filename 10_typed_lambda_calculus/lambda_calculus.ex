defmodule LambdaCalculus do
  defp add_binding(ctx, x, bind) do
    [{x, bind} | ctx]
  end

  defp get_type_from_context(ctx, i) do
    case get_binding(ctx, i) do
      {_, {:var_bind, type}} -> type
      _                      -> raise "wrong kind of binding"
    end
  end

  defp get_binding(ctx, i) do
    Enum.at(ctx, i)
  end

  def type_of(t) do
    type_of([], t)
  end

  def type_of(ctx, {:var, i}) do
    get_type_from_context(ctx, i)
  end

  def type_of(ctx, {:abs, x, type_t1, t2}) do
    new_ctx = add_binding(ctx, x, {:var_bind, type_t1})
    type_t2 = type_of(new_ctx, t2)
    {:type_arr, type_t1, type_t2}
  end

  def type_of(ctx, {:app, t1, t2}) do
    type_t1 = type_of(ctx, t1)
    type_t2 = type_of(ctx, t2)
    case type_t1 do
      {:type_arr, ^type_t2, type_t12} -> type_t12
      {:type_arr, _, _}               -> raise "parameter type mismatch"
      _                               -> raise "arrow type expected"
    end
  end

  def type_of(_, bool) when bool in [:true, :false] do
    :type_bool
  end

  def type_of(ctx, {:if, t1, t2, t3}) do
    (type_of(ctx, t1) == :type_bool) or raise "guard of conditioanl not a boolean"
    type_t2 = type_of(ctx, t2)
    type_t3 = type_of(ctx, t3)
    if type_t2 == type_t3 do
      type_t2
    else
      raise "arms of conditional have different types"
    end
  end
end
