### Customize a new vim development environment
It's a fantastic experience to customize a personal vim.

#### Install note
* YCM

  Well, YCM is a big system of completion and therefore it is hard to
  install and use. But nothing in the world is difficult for one who sets his
  mind to it.

  - installation problems
 
    There will be an error which says about missing libclang.so.*.
    You can add the directory to LD_LIBRARY_PATH which contains libclang.so.*.
    Or you can just link libclang.so.* to /usr/lib.

  - ycm_extra_config.py

    The first problem is the extra configuration for YCM. YCM would be
    not work if this config file has some error.

    The best solution is to use YCM_Generator
    (https://github.com/rdnetto/YCM-Generator)
