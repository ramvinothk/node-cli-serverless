const multipart = require("parse-multipart");
const util = require("util");
const fs = require("fs");
const s3 = require("aws-sdk/clients/s3");
const exec = util.promisify(require("child_process").exec);
const Multipart = require("lambda-multipart");

exports.handler = async function(event, context) {
  console.log("Headers");
  /**save the file to local tmp for execution
   *
   * @type {Buffer}
   */
  console.log(event.pathParameters);
  const body = Buffer.from(event.body);
  const boundary = multipart.getBoundary(event.headers["Content-Type"]);
  const buff = multipart.Parse(body, boundary);
  console.log(buff);
  // await fs.writeFileSync("test001.stl", body, "utf8");
  // await fs.createWriteStream("samplqe.stl").write(buff[0].data);
  // const params = {
  //   Bucket: "bucket1",
  //   Key: `request/text.txt`
  // };
  //
  // const { Body } = await s3.getObject(params).promise();
  // console.log(Body);
  let response = "";
  const { stdout, stderr } = await exec("prusa-slicer --help-fff");
  if (stdout) response = stdout;
  else response = stderr;
  return {
    statusCode: 200,
    body: JSON.stringify(response, null, 2)
  };
};
