context("SAVE_RUN")

test_that("save_run() works", {

  tmp <- tempfile(fileext = ".rds")

  out <- capture.output(
    res1 <- save_run({
      Sys.sleep(2)
      1
    }, file = tmp)
  )
  expect_length(out, 2)
  expect_identical(res1, 1)
  expect_failure(expect_identical(readRDS(tmp), 1))  # also attribute

  time2 <- system.time(
    out2 <- capture.output(
      res2 <- save_run({
        Sys.sleep(2)
        2
      }, file = tmp)
    )
  )
  expect_lte(time2[[3]], 0.1)
  expect_identical(res2, 1)
  expect_identical(out2, out)


  tmp2 <- tempfile(fileext = ".rds")

  expect_failure(expect_output({
    res3 <- save_run({
      Sys.sleep(2)
      3
    }, file = tmp2, timing = FALSE)
  }))
  expect_identical(res3, 3)

  expect_failure(expect_output({
    res4 <- save_run({
      Sys.sleep(2)
      2
    }, file = tmp2, timing = FALSE)
  }))
  expect_identical(res4, 3)
})
