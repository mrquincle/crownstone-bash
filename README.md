# Set of shell tools for Crownstone cloud

Tested in zsh shell.

# Dependencies

Install `jq` parser, for example:

    npm install -g jq2

# Use

Configuration file `.config` should not be committed to github and contains:

    email=youremail
    password=yoursha1hash

Perhaps, redundant info, but this is how you get your sha1 hash:

    echo -n "password" | sha1sum

Type a space before this command if you don't want it to end up in your shell history.

# Results

Result in output/curl.log

Feed through `jq` or `python -m json.tool` to pretty print. Former also accepts international characters (richer UTF encodings).

	< output/curl.log jq

You can use `jq` also to parse the json:

	cat output/curl.log | jq -r '.[].id' 
	cat output/curl.log | jq -r '.[] | .id,.ownerId' 

You can also use `underscore` https://github.com/ddopson/underscore-cli to parse.
Examples: 

	< output/curl.log underscore select .id
	< output/curl.log underscore select .id,.ownerId
	< output/curl.log underscore select .timestamp


# Examples

## Delete a Crownstone

Suppose you would like to remove a Crownstone from the database.

    ./get_stones.sh
    < output/curl.log underscore select .id,.name


This might result in the following array with for example:

    [
        "Crowny",
        "5a8f38cc9fe44d00178ee35b"
    ]

Finally, delete the stone:

    ./delete_stone.sh 5a8f38cc9fe44d00178ee35b

## Get information about a stone

Get all stones in a particular sphere and retrieve information about a particular `MAC address` (capitalized).

    ./get_owned_stones.sh SPHERE_ID
    < output/curl.log jq '.[] | select(.address == "F3:4F:C7:AB:27:37")'


