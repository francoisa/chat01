#include <FL/Fl_Window.h>
#include "chat.h"

using namespace std;

int main(int argc, char* argv[]) {
    make_window()->show(argc, argv);
    return Fl::run();
}
