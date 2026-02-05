defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real({real_part, _imaginary_part}) do
    real_part
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary({_real_part, imaginary_part}) do
    imaginary_part
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(a, b) do
    {real_a, imaginary_a} = normalize(a)
    {real_b, imaginary_b} = normalize(b)
    {real_a * real_b - imaginary_a * imaginary_b, imaginary_a * real_b + real_a * imaginary_b}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(a, b) do
    {real_a, imaginary_a} = normalize(a)
    {real_b, imaginary_b} = normalize(b)
    {real_a + real_b, imaginary_a + imaginary_b}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(a, b) do
    {real_a, imaginary_a} = normalize(a)
    {real_b, imaginary_b} = normalize(b)
    {real_a - real_b, imaginary_a - imaginary_b}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(a, b) do
    {real_a, imaginary_a} = normalize(a)
    {real_b, imaginary_b} = normalize(b)

    {(real_a * real_b + imaginary_a * imaginary_b) / (real_b ** 2 + imaginary_b ** 2),
     (imaginary_a * real_b - real_a * imaginary_b) / (real_b ** 2 + imaginary_b ** 2)}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs(a) do
    {real_a, imaginary_a} = normalize(a)

    :math.sqrt(real_a ** 2 + imaginary_a ** 2)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate(a) do
    {real_a, imaginary_a} = normalize(a)
    {real_a, imaginary_a * -1}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp(a) do
    {real_a, imaginary_a} = normalize(a)
    ea = :math.exp(real_a * 1.0)
    {ea * :math.cos(imaginary_a * 1.0), ea * :math.sin(imaginary_a * 1.0)}
  end

  defp normalize({real, imaginary}) when is_number(real) and is_number(imaginary),
    do: {real, imaginary}

  defp normalize(real) when is_number(real), do: {real, 0}
end
