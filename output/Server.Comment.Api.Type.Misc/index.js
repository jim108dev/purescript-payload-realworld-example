// Generated by purs version 0.13.8
"use strict";
var Data_Nullable = require("../Data.Nullable/index.js");
var mkSingleDto = function (i) {
    return {
        comment: {
            author: {
                bio: Data_Nullable.toNullable(i.author.bio),
                image: Data_Nullable.toNullable(i.author.image),
                username: i.author.username,
                following: i.author.following
            },
            body: i.body,
            createdAt: i.createdAt,
            id: i.id,
            updatedAt: i.updatedAt
        }
    };
};
var mkMultipleDto = function (comments) {
    return {
        comments: comments
    };
};
module.exports = {
    mkMultipleDto: mkMultipleDto,
    mkSingleDto: mkSingleDto
};
