require "formula"

class Knp < Formula
  homepage "http://nlp.ist.i.kyoto-u.ac.jp/index.php?KNP"
  url "http://nlp.ist.i.kyoto-u.ac.jp/DLcounter/lime.cgi?down=http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/knp-4.16.tar.bz2&name=knp-4.16.tar.bz2"
  sha256 "a500e04cbf581eda4c8d2be93d6eff9066069b6287a465b6c4050604bd5faeb5"

  depends_on "autoconf"
  depends_on "automake"
  depends_on "libtool"
  
  depends_on "juman"
  depends_on "tinycdb"
  depends_on "crf++"
  
  def patches
    [
      "https://github.com/tskoba/homebrew-knp/tree/master/Formula/remove-CRF++.patch",
      "https://github.com/tskoba/homebrew-knp/tree/master/Formula/remove-cdb.patch"
    ]
  end
  
  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-juman-prefix=#{HOMEBREW_PREFIX}/opt/juman
      --with-crf
    ]

    system "rm -rf CRF++-0.58 cdb"
    system "rm configure Makefile.in crf/Makefile.in ltmain.sh"
    system "glibtoolize"
    system "aclocal"
    system "automake -a"
    system "autoconf"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "false"
  end
end
