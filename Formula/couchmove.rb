# Generated with JReleaser 1.7.0 at 2024-02-29T05:59:28.024Z
class Couchmove < Formula
  desc "Couchmove is a database migration tool for Couchbase"
  homepage "https://github.com/tchlyah/couchmove"
  version "3.4"
  license "APACHE-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4/couchmove-3.4-linux-aarch_64.zip"
    sha256 "b304395364fc088b1522acbf598faf7557a0bade5647112ccbe5effa1c845234"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4/couchmove-3.4-linux-x86_64.zip"
    sha256 "7997de9e9e228310c2676f69032607bb07a2e9b859865bcb96a3b01c9109163d"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4/couchmove-3.4-osx.zip"
    sha256 "61b79569996b5c5d93451d60ffcad03ad26b5e36545d50d5734ddbeaf08715b2"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4/couchmove-3.4-osx-aarch_64.zip"
    sha256 "b61716e064435ebe244cf746cba870989cb53f9d2f3517eaea3c92703dacdde9"
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
    assert_match "3.4", output
  end
end
