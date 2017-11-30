# Use

Configuration file `.config` should not be committed to github and contains:

    email=youremail
    password=yoursha1hash

Perhaps, redundant info, but this is how you get your sha1 hash:

    echo -n "password" | sha1sum

Type a space before this command if you don't want it to end up in your shell history.

# Results

Result in output/curl.log

Feed through json.tool to pretty print: 

	< output/curl.log python -m json.tool

Use e.g. https://github.com/ddopson/underscore-cli to parse at command line
Examples: 

	< output/curl.log underscore select .id
	< output/curl.log underscore select .id,.address
	< output/curl.log underscore select .timestamp
