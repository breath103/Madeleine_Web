var list = new LinkedList();

function Element() {
}

Element.prototype.prev = null; // ��� �몃� 李몄“.
Element.prototype.next = null; // ��� �몃� 李몄“.
Element.prototype.data = null; // �몃���媛�

function LinkedList() {
}

LinkedList.prototype.head = null; // head node.
LinkedList.prototype.tail = null; // tail node.
LinkedList.prototype.length = 0; // node�ㅼ� 媛��.

// index �����value瑜�媛��濡�媛�� element 異��.
LinkedList.prototype.add = function(index, value) {
	
	try {
		// index媛��レ��몄� 寃��.
		// fasle��寃쎌� : �レ�, true��寃쎌� : 臾몄�.
		if (isNaN(index)) { // index媛�臾몄���寃쎌� exception 諛��.
//		throw "index is not number.";
			throw "Err1";
		}
		
		// index媛�0蹂대� ��굅��length + 1蹂대� ��寃쎌� exception.
		if (index < 0 || index > this.length + 1) {
//		throw "index out of bounds.";
			throw "Err2";
		}
	} catch(er) {
		if(er == "Err1") {
			alert("index is not number.");
		} else if(er == "Err2") {
			alert("index out of bounds.");
		}
	}

	// element ���.
	var e = new Element();
	e.data = value;

	// 1. 理����異��.
	// 2. 0踰�㎏ �몃���異��.
	// 3. 留��留��몃���異��.
	// 4. 以�� �몃���異��.
	if (index == 0) { // 0踰�㎏ �몃���element瑜�異����寃쎌�.
		if (this.length == 0) { // 理����異����寃쎌�.
			this.head = e;
			this.tail = e;
		} else { // �몃��ㅼ� 議댁������0踰�㎏ �몃���異����寃쎌�.
			e.prev = null;
			e.next = this.head;
			e.next.prev = e;
			this.head = e;
		}
	} else if (index == this.length) { // 留��留��몃���element瑜�異����� 寃쎌�.
		e.prev = this.tail;
		e.prev.next = e;
		e.next = null;
		this.tail = e;
	} else { // 以�� �몃���element瑜�異����� 寃쎌�.
		// ��� 異����������몃�瑜����.
		var target = this.getElement(index);

		// ��� �몃���李몄“瑜���� 異�����몃�濡�媛깆�.
		e.prev = target.prev;
		e.next = target;
		target.prev.next = e;
		target.prev = e;
	}

	this.length++; // �몃� 媛�� 利��.
};

// index �������� element ��� 諛�element 媛�諛��.
LinkedList.prototype.remove = function(index) {
	try {
		// index媛��レ��몄� 寃��.
		// fasle��寃쎌� : �レ�, true��寃쎌� : 臾몄�.
		if (isNaN(index)) { // index媛�臾몄���寃쎌� exception 諛��.
//		throw "index is not number.";
			throw "Err1";
		}
		
		// index媛�0蹂대� ��굅��length + 1蹂대� ��寃쎌� exception.
		if (index < 0 || index > this.length + 1) {
//		throw "index out of bounds.";
			throw "Err2";
		}
	} catch(er) {
		if(er == "Err1") {
			alert("index is not number.");
		} else if(er == "Err2") {
			alert("index out of bounds.");
		}
	}
	
	// ������몃� ���.
	var e = this.getElement(index);
	
	if(this.length == 1) { // 1媛�� �몃�留�議댁�������대� element瑜������� 寃쎌�.
		this.head = null;
		this.tail = null;
	} else if(index == 0) { // 0踰�㎏ �몃���element瑜������� 寃쎌�.
		this.head = e.next;
		e.next.prev = null;
	} else if(index == this.length - 1){ // 留��留��몃���element瑜������� 寃쎌�.
		this.tail = e.prev;
		e.prev.next = null;
	} else { // 以�� �몃���element瑜������� 寃쎌�.
		e.prev.next = e.next;
		e.next.prev = e.prev;
	}
	
	this.length--; // �몃� 媛�� 媛��.
	
	return e.data;
};

// index �������� element 諛��.
LinkedList.prototype.getElement = function(index) {
	try {
		// index媛��レ��몄� 寃��.
		// fasle��寃쎌� : �レ�, true��寃쎌� : 臾몄�.
		if (isNaN(index)) { // index媛�臾몄���寃쎌� exception 諛��.
//		throw "index is not number.";
			throw "Err1";
		}
		
		// index媛�0蹂대� ��굅��length + 1蹂대� ��寃쎌� exception.
		if (index < 0 || index > this.length + 1) {
//		throw "index out of bounds.";
			throw "Err2";
		}
	} catch(er) {
		if(er == "Err1") {
			alert("index is not number.");
		} else if(er == "Err2") {
			alert("index out of bounds.");
		}
	}
	
	// ��� 寃����������몃�瑜����.
	if (index > this.length - index) { // ��� 寃��.
		// ��� 寃����������몃�瑜����.
		var target = this.tail;
		for ( var i = this.length - 2; i >= index; i--) {
			target = target.prev;
		}
		return target;
		
	} else { // ��� 寃��.
		// ��� 寃����������몃�瑜����.
		var target = this.head;
		for ( var i = 1; i <= index; i++) {
			target = target.next;
		}
		return target;
	}
};

// index �������� element 媛�諛��.
LinkedList.prototype.get = function(index) {
	try {
		// index媛��レ��몄� 寃��.
		// fasle��寃쎌� : �レ�, true��寃쎌� : 臾몄�.
		if (isNaN(index)) { // index媛�臾몄���寃쎌� exception 諛��.
//		throw "index is not number.";
			throw "Err1";
		}
		
		// index媛�0蹂대� ��굅��length + 1蹂대� ��寃쎌� exception.
		if (index < 0 || index > this.length + 1) {
//		throw "index out of bounds.";
			throw "Err2";
		}
	} catch(er) {
		if(er == "Err1") {
			alert("index is not number.");
		} else if(er == "Err2") {
			alert("index out of bounds.");
		}
	}
	
	var target = this.getElement(index);
	
	return target.data;
};

// list��媛�異����린.
function addValue(index, value) {
	list.add(index, value);
	
	updateListView();
	
}

// list 蹂댁�二쇨린.
function updateListView() {
	var listView = document.getElementById("listView");
	
	// listView����������紐⑤� 珥�린��
	// listView.childNodes濡��������ㅼ� �����寃쎌� for臾몄� length��� error 諛��.
	while(listView.firstChild) {
		listView.removeChild(listView.firstChild);
	}
	
	// listView�������� 異��.
	for(var i=0 ; i<list.length ; i++) {
		// i踰�㎏ element 媛���ㅺ린.
		var element = list.getElement(i);
		
		var input = document.createElement("input");

		input.setAttribute("type", "button");
		input.setAttribute("value", element.data);
		input.setAttribute("index", i);
		input.style.width = "20px";
		input.style.height = element.data + "px"; // data���ш린���곕� ���媛��щ�吏�
		input.style.verticalAlign = "bottom";
		
		// �대깽��由ъ���異��. (踰�� �대┃��element ���.)
		if(input.addEventListener) { // 紐⑥���怨�����대깽���깅� 硫����
			input.addEventListener("click", removeListButton, false);
		} else if(input.attachEvent) { // IE6 �댄�,�ы�由��щ＼���대깽���깅� 硫����
			input.attachEvent("onclick", removeListButton);
		}
		
		listView.appendChild(input);
	}
}

// list �����린.
function removeListButton(event) {
	var target;
	
	if(event.target) {
		target = event.target;
	} else if(event.srcElement) {
		target = event.srcElement;
	}
	
	list.remove(target.getAttribute("index"));
	
	updateListView();
}

// 踰�����.
function sortList() {
	
	if(list.length > 0) { // list��element媛�議댁�瑜����硫����.
		for(var i=list.length-1 ; i>0 ; i--) { // ��� 援ш� 媛��.
			// list��泥ル�吏�element瑜�媛����
			var e = list.getElement(0);
			for(var j=0 ; j<i ; j++) { // 援ш������ ���.
				if(e.next != null) { // e �ㅼ� 鍮�����몃�媛���� 寃쎌�.
					if(e.data > e.next.data) {
						var temp1 = e; // e �몃�����낫.
						var temp2 = e.next; // e���ㅼ� �몃� ��낫.
						
						// 1. e���댁� �몃������ 留��瑜�e.next濡�諛��.
						// 2. e.next���ㅼ� �몃������ 留��瑜�e濡�諛��.
						// 3. e.next �몃������ 留��瑜�e.perv濡�諛��. 
						// 4. e �몃������ 留��瑜�e.next.next濡�諛��.
						// 5. 
						// 6.
						e.prev.next = e.next;
						e.next.next.prev = e;
						e.next.prev = e.prev;
						e.next = e.next.next;
						e.next.next = e;
						e.prev = e.next;
					}
				}
				
			}
		}
	}
}