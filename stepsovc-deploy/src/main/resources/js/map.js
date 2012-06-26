function (doc) {
    if (doc.doc_type === 'CommCareCase') {
        if (doc.owner_id) {
		var owner_ids = doc.owner_id.toString().split(",");
		for(var i in owner_ids){
			emit([owner_ids[i], doc.closed], null);
		}
            
        } else {
            emit([doc.user_id, doc.closed], null);
        }
    }
}
