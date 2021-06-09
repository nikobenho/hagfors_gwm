import os
import multiprocessing as mp
import numpy as np
import pandas as pd
import pyemu
import flopy
def main():

    try:
       os.remove(r'head.obs.csv')
    except Exception as e:
       print(r'error removing tmp file:head.obs.csv')
    pyemu.helpers.apply_list_and_array_pars(arr_par_file='mult2model_info.csv',chunk_len=50)
    pyemu.os_utils.run(r'mf6')


if __name__ == '__main__':
    mp.freeze_support()
    main()

