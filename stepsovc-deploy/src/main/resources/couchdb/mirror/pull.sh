IFS=";"
export IFS
rm -rf files
mkdir files
ids=$(curl -X POST http://localhost:5984/commcarehq/_temp_view   -H "Content-Type: application/json" -d @doc_to_download_view | jsawk 'appIds=""; for(i=0;i<this.rows.length;i++) appIds=appIds+this.rows[i].id+";"; return appIds;')
for id in $ids; do
	url="http://localhost:5984/commcarehq/$id"
	doc=$(curl $url)
	attachments=$(echo $doc | jsawk 'attachments=""; for(key in this._attachments) attachments+=key+";"; return attachments')
	for attachment in $attachments; do
		attach_url="http://localhost:5984/commcarehq/$id/$attachment"
		attach_doc=$(curl $attach_url)
		echo $attach_doc > files/$attachment
	done
	echo $doc > files/$id.json
done
