import requests
import re
import os
import csv


###############################################################################
# First, let's write some functions to get the data from the web.
###############################################################################

# define the URL of the main page of the bolha cats listing
cats_frontpage_url = 'http://www.bolha.com/zivali/male-zivali/macke/'
# the directory to which we save our data
cat_directory = 'cat_data'
# the filename we use to save the frontpage
frontpage_filename = 'frontpage.html'
# the filename for the CSV file for the extracted data
csv_filename = 'cat_data.csv'


def download_url_to_string(url):
    '''This function takes a URL as argument and tries to download it
    using requests. Upon success, it returns the page contents as string.'''
    try:
        # del kode, ki morda sproži napako
        r = requests.get(url)
    except requests.exceptions.ConnectionError:
        # koda, ki se izvede pri napaki
        print("Could not access page " + url)
        # dovolj je če izpišemo opozorilo in prekinemo izvajanje funkcije
        return ''
    # nadaljujemo s kodo če ni prišlo do napake
    return r.text


def save_string_to_file(text, directory, filename):
    '''Write "text" to the file "filename" located in directory "directory",
    creating "directory" if necessary. If "directory" is the empty string, use
    the current directory.'''
    os.makedirs(directory, exist_ok=True)
    path = os.path.join(directory, filename)
    with open(path, 'w', encoding='utf-8') as file_out:
        file_out.write(text)
    return None

# Define a function that downloads the frontpage and saves it to a file.


def save_frontpage(url):
    '''Save "cats_frontpage_url" to the file
    "cat_directory"/"frontpage_filename"'''
    text = download_url_to_string(url)
    return save_string_to_file(text, cat_directory, frontpage_filename)

###############################################################################
# Now that we have some data, we can think about processing it.
###############################################################################


def read_file_to_string(directory, filename):
    '''Return the contents of the file "directory"/"filename" as a string.'''
    path = os.path.join(directory, filename)
    with open(path, 'r') as file_in:
        return file_in.read()


# Define a function that takes a webpage as a string and splits it into
# segments such that each segment corresponds to one advertisement. This
# function will use a regular expression that delimits the beginning and end of
# each ad. Return the list of strings.
# Hint: To build this reg-ex, you can use your text editor's regex search
# functionality.

pattern = r'\b<div class="ad\s?featured?">.*?</div>\b'
def page_to_ads(pattern, text):
    '''Split "page" to a list of advertisement blocks.'''
    for match in re.findall(pattern, text):
        return print(match)
    


# Define a function that takes a string corresponding to the block of one
# advertisement and extracts from it the following data: Name, price, and
# the description as displayed on the page.


def get_dict_from_ad_block(TODO):
    '''Build a dictionary containing the name, description and price
    of an ad block.'''
    return TODO

# Write a function that reads a page from a file and returns the list of
# dictionaries containing the information for each ad on that page.


def ads_from_file(TODO):
    '''Parse the ads in filename/directory into a dictionary list.'''
    return TODO

###############################################################################
# We processed the data, now let's save it for later.
###############################################################################


def write_csv(fieldnames, rows, directory, filename):
    '''Write a CSV file to directory/filename. The fieldnames must be a list of
    strings, the rows a list of dictionaries each mapping a fieldname to a
    cell-value.'''
    os.makedirs(directory, exist_ok=True)
    path = os.path.join(directory, filename)
    with open(path, 'w') as csv_file:
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)
    return None

# Write a function that takes a non-empty list of cat advertisement
# dictionaries and writes it to a csv file. The [fieldnames] can be read off
# the dictionary.


def write_cat_ads_to_csv(TODO):
    '''Write a CSV file containing one ad from "ads" on each row.'''
    return TODO
