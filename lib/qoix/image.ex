defmodule Qoix.Image do
  @moduledoc """
  A struct representing a raw image.
  """

  @enforce_keys [:width, :height, :pixels, :format, :colorspace]
  defstruct [:width, :height, :pixels, :format, :colorspace]

  @type colorspace :: :srgb | :linear
  @type format :: :rgb | :rgba
  @type t :: %__MODULE__{
          width: pos_integer,
          height: pos_integer,
          pixels: binary,
          format: format,
          colorspace: colorspace
        }

  alias __MODULE__

  @doc """
  Creates a new `Qoix.Image` with :rgb format.

  `pixels` must be a binary of RGB values.

  It's possible to pass an optional `colorspace`, which must be one of `:srgb`
  (sRGB with linear alpha) or `:linear` (all channels linear). If nothing is
  passed, the default is `:srgb`

  ## Examples

      iex> image = File.read!("test/support/images/elixir-logo.png")
      iex> Qoix.Image.from_rgb(554, 690, image)
      %Qoix.Image{
        colorspace: :srgb,
        format: :rgb,
        height: 690,
        pixels: "\x89PNG\r\n\x1A\n\0\0\0\rIHDR\0\0\x02*" <> ...,
        width: 554
      }

  """
  @spec from_rgb(pos_integer, pos_integer, binary, colorspace) :: t
  def from_rgb(width, height, pixels, colorspace \\ :srgb)
      when is_integer(width) and is_integer(height) and is_binary(pixels) and width > 0 and
             height > 0 and colorspace in [:srgb, :linear] do
    %Image{
      width: width,
      height: height,
      pixels: pixels,
      format: :rgb,
      colorspace: colorspace
    }
  end

  @doc """
  Creates a new `Qoix.Image` with :rgba format.

  `pixels` must be a binary of RGBA values.

  It's possible to pass an optional `colorspace`, which must be one of `:srgb` (sRGB with linear
  alpha) or `:linear` (all channels linear). If nothing is passed, the default is `:srgb`
  """
  @spec from_rgba(pos_integer, pos_integer, binary, colorspace) :: t
  def from_rgba(width, height, pixels, colorspace \\ :srgb)
      when is_integer(width) and is_integer(height) and is_binary(pixels) and width > 0 and
             height > 0 and colorspace in [:srgb, :linear] do
    %Image{
      width: width,
      height: height,
      pixels: pixels,
      format: :rgba,
      colorspace: colorspace
    }
  end
end
