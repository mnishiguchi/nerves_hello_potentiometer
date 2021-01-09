defmodule NervesHelloPotentiometer do
  @moduledoc false

  require Logger

  @doc """
  Hello world.

  ## Examples

      iex> NervesHelloPotentiometer.hello
      :world

  """
  def hello do
    :world
  end

  @doc """
  ## Examples

      NervesHelloPotentiometer.start_logging_demo()
  """
  def start_logging_demo() do
    RingLogger.attach

    "spidev0.0"
    |> open_potentiometer()
    |> log_potentiometer_forever(1000)
  end

  @doc """
  ## Examples

      NervesHelloPotentiometer.start_servo_demo()
  """
  def start_servo_demo() do
    RingLogger.attach

    servo_pid =
      ServoKit.init_standard_servo(%{
        i2c_bus: "i2c-1",
        duty_cycle_minmax: {2.5, 12.5},
        angle_max: 180
      })

    "spidev0.0"
    |> open_potentiometer()
    |> read_potentiometer_callback_forever(
      1000,
      fn ten_bit_value ->
        angle = ten_bit_value |> angle_from_ten_bit() |> round()
        ServoKit.set_angle(servo_pid, 0, angle)
      end
    )
  end

  def read_potetetiometer(spi_ref) do
    {:ok, <<_::size(6), ten_bit_value::size(10)>>} = Circuits.SPI.transfer(spi_ref, <<0x68, 0x00>>)
    ten_bit_value
  end

  def open_potentiometer(spi_device) do
    {:ok, ref} = Circuits.SPI.open(spi_device)
    ref
  end

  def read_potentiometer_callback_forever(spi_ref, interval, callback_fn) do
    ten_bit_value = read_potetetiometer(spi_ref)
    callback_fn.(ten_bit_value)
    Process.sleep(interval)
    read_potentiometer_callback_forever(spi_ref, interval, callback_fn)
  end

  def log_potentiometer_forever(spi_ref, interval) do
    read_potentiometer_callback_forever(spi_ref, interval, fn ten_bit_value ->
      percent_value = map_range(ten_bit_value, {0, 1023}, {0, 100})
      Logger.info("#{ten_bit_value} (#{percent_value}%)")
    end)
  end

  defp angle_from_ten_bit(ten_bit_value) do
    map_range(ten_bit_value, {0, 1023}, {180, 0})
  end

  defp map_range(x, {in_min, in_max}, {out_min, out_max}) do
    (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
  end
end
