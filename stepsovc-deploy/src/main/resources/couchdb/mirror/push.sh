IFS=";"
export IFS

rev=""
for app_file in *.json; do
        url="http://localhost:5984/test/${app_file:0:${#app_file}-5}"
	attachments=$(cat $app_file | jsawk 'attachments=""; for(key in this._attachments)attachments+=key+";"; return attachments')
	#curl $url	
	existing=$(curl -s $url | grep { | jsawk 'return this._rev')
	#echo "existing $existing ********************"
	curl -i -X DELETE $url -H "If-Match: $existing"
	
	modified_app=$(cat $app_file | jsawk 'delete this._rev; delete this._attachments;')
        #echo "modified app $modified_app"
        revno=$(curl -s -i -X PUT $url -H "Content-Type:application/json"  -d $modified_app | grep { | jsawk 'return this.rev')
	rev="?rev=$revno"
	for attachment in $attachments; do
		#echo $rev
		attach_url="$url/$attachment$rev"
		echo $attach_url
		type=$(cat $app_file | jsawk 'return this._attachments["'$attachment'"].content_type')
		revno=$(curl -v -s -X PUT $attach_url --data-binary @$attachment -H "Content-Type: $type" | grep { | jsawk 'return this.rev')
		rev="?rev=$revno"
	done
	rev=""
done
