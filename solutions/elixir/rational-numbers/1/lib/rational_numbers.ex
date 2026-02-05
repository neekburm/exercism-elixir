defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) when b1 > 0 and b2 > 0 do
    numerator = a1 * b2 + a2 * b1
    denominator = b1 * b2
    reduce({numerator, denominator})
  end

  def add(_a, _b), do: raise("Cannot divide by zero")

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) when b1 != 0 and b2 != 0 do
    numerator = a1 * b2 - a2 * b1
    denominator = b1 * b2
    reduce({numerator, denominator})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) when b1 != 0 and b2 != 0 do
    numerator = a1 * a2
    denominator = b1 * b2
    reduce({numerator, denominator})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) when b1 != 0 and b2 != 0 do
    numerator = a1 * b2
    denominator = a2 * b1
    reduce({numerator, denominator})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a, b}) when b != 0 do
    reduce({Kernel.abs(a), Kernel.abs(b)})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer):: rational
  def pow_rational({a, b}, n) when n >= 0 do
    reduce({a**n, b**n})
  end
  def pow_rational({a, b}, n) when n < 0 do
    reduce({b**Kernel.abs(n), a**Kernel.abs(n)})
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    nth_root(x**a, b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a1, b1}) do
    gcd = Integer.gcd(a1, b1)

    if b1 < 0 and a1 > 0 or b1 < 0 and a1 < 0 do
      {div(-a1, gcd), div(-b1, gcd)}
    else
      {div(a1, gcd), div(b1, gcd)}
    end
  end

  defp nth_root(x, n) when is_number(x) and is_number(n) and n != 0 do
    :math.pow(x, 1 / n)
  end
end
