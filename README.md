# NervesHelloPotentiometer

A demo project for [[Elixir/Nerves] Potentiometer with SPI-based Analog to Digital Converter](https://dev.to/mnishiguchi/elixir-nerves-potentiometer-with-spi-based-analog-to-digital-converter-25h1).

## Usage

SSH to your target device and run the following commands.

### The logging demo

```elixir
NervesHelloPotentiometer.start_logging_demo()
```

![spi-potentiometer-readings](https://user-images.githubusercontent.com/7563926/104030802-ef34e780-5199-11eb-99d0-4f9afcb8b0d7.gif)

### The servo demo

```elixir
NervesHelloPotentiometer.start_servo_demo()
```

![potentiometer-servo](https://user-images.githubusercontent.com/7563926/104080569-d7d81780-51f6-11eb-9c93-43361156c167.gif)

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

## Getting Started

To start your Nerves app:
  * `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi3`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves
