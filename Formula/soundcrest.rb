class Soundcrest < Formula
  desc "Live waveform of whatever your computer is playing"
  homepage "https://github.com/carsonfischl/soundcrest"
  url "https://github.com/carsonfischl/soundcrest/archive/refs/tags/v0.4.3.tar.gz"
  sha256 "f6e69242bbdbe4174e067ee08a038c85e59d86289b47d02600f567944195e08e"
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
