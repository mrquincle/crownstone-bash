# Use

Configuration file `.config` should not be committed to github and contains:

    email=youremail
    password=yoursha1hash

# Results

Result in output/curl.log

Feed through json.tool to pretty print: 

	< output/curl.log python -m json.tool

Use e.g. https://github.com/ddopson/underscore-cli to parse at command line
Examples: 

	< output/curl.log underscore select .id
	< output/curl.log underscore select .id,.address
	< output/curl.log underscore select .timestamp
