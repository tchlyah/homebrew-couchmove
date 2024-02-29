# Generated with JReleaser 1.7.0 at 2024-02-29T07:15:40.367Z
class Couchmove < Formula
  desc "Couchmove is a database migration tool for Couchbase"
  homepage "https://github.com/tchlyah/couchmove"
  version "3.4.1"
  license "APACHE-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4.1/couchmove-3.4.1-linux-aarch_64.zip"
    sha256 "e495c603ccb245b066be3ad37b29b436c8819507ca03f332708f71d5357c192c"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4.1/couchmove-3.4.1-linux-x86_64.zip"
    sha256 "aa311d1d6cbbf379e6fab5da6b00b09ef1b8d25178abb9a4a0bbf6a36eb59b86"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4.1/couchmove-3.4.1-osx.zip"
    sha256 "71ef85fb66305030ea86c44d83d5489f82e6407f04d9f901831040712ac5a39a"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4.1/couchmove-3.4.1-osx-aarch_64.zip"
    sha256 "ebe8eb5677791d8a606d2a46532b194179845b98b36910d96cc52c646ba52ea7"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/couchmove" => "couchmove"
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib) if Hardware::CPU.arm?
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/couchmove --version")
    assert_match "3.4.1", output
  end
end
