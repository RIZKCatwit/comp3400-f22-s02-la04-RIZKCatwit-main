add_executable(parta parta.c)
target_compile_features(parta PUBLIC c_std_11)
target_compile_options(parta PUBLIC -Wall -Wextra -Wvla -Wno-unused-parameter -ggdb)

add_executable(partb partb.c)
target_compile_features(partb PUBLIC c_std_11)
target_compile_options(partb PUBLIC -Wall -Wextra -Wvla -Wno-unused-parameter -ggdb)

