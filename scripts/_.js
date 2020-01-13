var request = require("request");

const result = {}
async function get(id) {
  var options = { method: 'POST',
    url: 'http://www.mymarianas.cn/index/change_img',
    headers: 
    { 
      'cache-control': 'no-cache',
      'Content-Type': 'multipart/form-data',
    },
    formData: { id: id } };

  request(options, function (error, response, body) {
    if (error) throw new Error(error);
    body = JSON.parse(body)
    console.log(body)
    console.log(',')
  });
}

[45, 44, 43, 42, 41, 17, 6, 16].forEach(async id => {
  await get(id)
})
