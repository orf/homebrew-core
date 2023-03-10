class Cross < Formula
  desc "Zero setup cross compilation and cross testing of Rust crates"
  homepage "https://github.com/cross-rs/cross"
  url "https://github.com/cross-rs/cross/archive/refs/tags/v0.2.5.tar.gz"
  sha256 "8dfcad7aa8eb0b9ce18423c386fc03bc709e8c9ad2d7bcb1a77f9d1d1cd6fd2e"
  license "MIT"
  head "https://github.com/cross-rs/cross.git", branch: "main"

  depends_on "rust" => :build
  depends_on "docker" => :test
  depends_on "rustup-init"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "cargo", "new", "hello_world", "--bin"
    cd "hello_world" do
      assert_match "Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running",
                   shell_output("#{bin}/cross build --target powerpc-unknown-linux-gnu 2>&1", 125)
    end
  end
end
