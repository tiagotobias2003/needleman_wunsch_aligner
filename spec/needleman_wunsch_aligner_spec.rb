# -*- coding: utf-8 -*-

require_relative './spec_helper'

describe NeedlemanWunschAligner do

  let(:aligner){ NeedlemanWunschAligner.new([1,2,3], [2,3,4]) }

  describe "#get_optimal_alignment" do

    [
      [
        [1,2,3],
        [1,2,3],
        [
          [1,2,3],
          [1,2,3]
        ]
      ],
      [
        [1,2,3],
        [2,3,4],
        [
          [  1,2,3,nil],
          [nil,2,3,4]
        ]
      ],
      [
        [2],
        [1,2,3],
        [
          [nil,2,nil],
          [1  ,2,3]
        ]
      ],
      [
        [1,1,1,1],
        [2,2,2,2],
        [
          [nil,nil,nil,nil,1  ,1  ,1  ,1],
          [2  ,2  ,2  ,2  ,nil,nil,nil,nil]
        ]
      ],
      [
        [1,1,1,1],
        [2,2,2,1],
        [
          [nil,nil,nil,1  ,1  ,1  ,1],
          [2  ,2  ,2  ,nil,nil,nil,1]
        ]
      ],
    ].each do |(seq_a, seq_b, optimal_alignment)|

      it "returns the optimal_alignment" do
        a = NeedlemanWunschAligner.new(seq_a, seq_b)
        a.get_optimal_alignment.must_equal(optimal_alignment)
      end

    end

  end

  describe "#compute_score" do

    [
      [1, 1, 1],
      [1, 2, -3],
    ].each do |(left_el, right_el, xpect)|

      it "handles #{ left_el.inspect }:#{ right_el.inspect }" do
        aligner.send(:compute_score, left_el, right_el).must_equal(xpect)
      end

    end
  end

  describe "#default_gap_penalty" do

    it 'returns the expected value' do
      aligner.send(:default_gap_penalty).must_equal(-1)
    end

  end

  describe "#gap_indicator" do

    it 'returns the expected value' do
      aligner.send(:gap_indicator).must_equal(nil)
    end

  end

  describe "#inspect_alignment" do

    it 'prints the alignment' do
      aligner.inspect_alignment.must_equal([
        '                   1 | nil                 ',
        '                   2 | 2                   ',
        '                   3 | 3                   ',
        '                 nil | 4                   ',
      ].join("\n"))
    end

    it 'adjusts the column width' do
      aligner.inspect_alignment(4).must_equal([
        '   1 | nil ',
        '   2 | 2   ',
        '   3 | 3   ',
        ' nil | 4   ',
      ].join("\n"))
    end

  end

end
