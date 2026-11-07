class Soundcrest < Formula
  desc "Live waveform of whatever your computer is playing"
  homepage "https://github.com/carsonfischl/soundcrest"
  url "https://github.com/carsonfischl/soundcrest/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "4ca2f05cbe5ba046ea2839cc5647e02a36b8623b4912383773b7261b95c8dff5"
  license "MIT"

  depends_on "tmux"

  uses_from_macos "swift" => :build

  on_macos do
    depends_on macos: :sonoma
  end

  def install
    odie "soundcrest requires macOS 14.2 or later" if OS.mac? && MacOS.full_version < "14.2"

    system "swift", "build", *std_swift_args
    bin.install ".build/release/soundcrest"
  end

  def caveats
    on_linux do
      <<~EOS
        soundcrest records audio with parec from your distribution's PulseAudio
        tools, which also work with PipeWire:
          Debian, Ubuntu, Fedora: install pulseaudio-utils
          Arch: install libpulse
      EOS
    end
  end

  test do
    assert_match "usage: soundcrest", shell_output("#{bin}/soundcrest --help")
  end
end
