defmodule LambdaCalculus do
  def to_string(ctx, term) do
    case term do
      {:abs, x, t1} ->
        {ctx2, x2} = pickfreshname(ctx, x)
        "(λ#{x2}. #{to_string(ctx2, t1)})"
      {:app, t1, t2} ->
        "(#{to_string(ctx, t1)} #{to_string(ctx, t2)})"
      {:var, n} ->
        index2name(ctx, n)
    end
  end

  def pickfreshname(ctx, x) do
    if Enum.member?(ctx, x) do
      pickfreshname(ctx, "#{x}'")
    else
      {[x | ctx], x}
    end

  end

  def index2name(ctx, n) do
    Enum.at(ctx, n)
  end
end
