defmodule Helpers do
  def abs(x, type, t) do
    {:abs, x, type, t}
  end

  def var(n) do
   {:var, n}
  end

  def app(t1, t2) do
    {:app, t1, t2}
  end
end
