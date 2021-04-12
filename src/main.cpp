#include <sstream>
#include <string>

#include "gflags/gflags.h"

#include "version.hpp"

namespace com::oxyjiang::photo_sign {

void set_version_string() {
  std::ostringstream osstr;
  osstr << IMAGE_SIGN_VERSION_MAJOR << "." << IMAGE_SIGN_VERSION_MINOR;
  osstr.flush();
  gflags::SetVersionString(osstr.str());
}

void set_usage_message() {
  gflags::SetUsageMessage("src_image sign_image");
}

int main(int argc, char **argv) {
  set_version_string();
  set_usage_message();
  gflags::ParseCommandLineFlags(&argc, &argv, true);
  return 0;
}

} // namespace com::oxyjiang::photo_sign

int main(int argc, char **argv) {
  return com::oxyjiang::photo_sign::main(argc, argv);
}
