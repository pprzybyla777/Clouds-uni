const asyncHandler = require("express-async-handler");
const { Product } = require("../Models/Products");

const getReport = asyncHandler(async (req, res) => {
  const totalProducts = await Product.countDocuments();
  const totalQuantity = await Product.aggregate([
    {
      $group: {
        _id: null,
        totalQuantity: {
          $sum: "$quantity",
        },
      },
    },
  ]);
  const totalPrice = await Product.aggregate([
    {
      $group: {
        _id: null,
        totalPrice: {
          $sum: "$price",
        },
      },
    },
  ]);
  const maxPrice = await Product.aggregate([
    {
      $group: {
        _id: null,
        maxPrice: {
          $max: "$price",
        },
      },
    },
    {
      $lookup: {
        from: "products",
        localField: "maxPrice",
        foreignField: "price",
        as: "maxPriceItem",
      },
    },
    {
      $unwind: "$maxPriceItem",
    },
  ]);
  const minPrice = await Product.aggregate([
    {
      $group: {
        _id: null,
        minPrice: {
          $min: "$price",
        },
      },
    },
    {
      $lookup: {
        from: "products",
        localField: "minPrice",
        foreignField: "price",
        as: "minPriceItem",
      },
    },
    {
      $unwind: "$minPriceItem",
    },
  ]);
  const averagePrice = await Product.aggregate([
    {
      $group: {
        _id: null,
        averagePrice: {
          $avg: "$price",
        },
      },
    },
  ]);

  const report = {
    totalProducts,
    totalQuantity,
    totalPrice,
    averagePrice,
    maxPrice,
    minPrice,
  };

  if (!report) {
    return res
      .status(400)
      .json({ message: "Sorry, can't generate the report." });
  }

  res.status(200).json(report);
});

module.exports = {
  getReport,
};
