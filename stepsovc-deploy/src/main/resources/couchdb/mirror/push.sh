IFS=";"
export IFS
cd files
rev=""
for doc_file_name in *.json; do
        url="http://localhost:5984/test/${doc_file_name:0:${#doc_file_name}-5}"
	attachments=$(cat $doc_file_name | jsawk 'attachments=""; for(key in this._attachments)attachments+=key+";"; return attachments')
	prev_rev=$(curl $url | grep { | jsawk 'return this._rev')
	#curl -i -X DELETE $url -H "If-Match: $existing"
	
	modified_app=$(cat $doc_file_name | jsawk 'this._rev="'$prev_rev'"; delete this._attachments;')
        #echo "modified app $modified_app"
        revno=$(curl -i -X PUT $url -H "Content-Type:application/json"  -d $modified_app | grep { | jsawk 'return this.rev')
	rev="?rev=$revno"
	for attachment in $attachments; do
		#echo $rev
		attach_url="$url/$attachment$rev"
		echo $attach_url
		type=$(cat $doc_file_name | jsawk 'return this._attachments["'$attachment'"].content_type')
		revno=$(curl -v -X PUT $attach_url --data-binary @$attachment -H "Content-Type: $type" | grep { | jsawk 'return this.rev')
		rev="?rev=$revno"
	done
	rev=""
done
