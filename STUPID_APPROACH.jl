#  σᵢ-> index
# -1 -> 1
#  1 -> 2
TEdge(i, j) = exp(- (i * 2 - 3) * (j * 2 - 3))

function TVertex(i, j, k)
    return i==j==k ? 1 : 0
end

function TStar(i1, i2, i3, i4, i5)
    rtn = 0
    for i1a in [1, 2]
        for i2a in [1, 2]
            for i3a in [1, 2]
                for i4a in [1, 2]
                    for i5a in [1, 2]
                        for i1b in [1, 2]
                            for i2b in [1, 2]
                                for i3b in [1, 2]
                                    for i4b in [1, 2]
                                        for i5b in [1, 2]
                                            rtn +=
                                            TVertex(i1, i1a, i1b) *
                                            TVertex(i2, i2a, i2b) *
                                            TVertex(i3, i3a, i3b) *
                                            TVertex(i4, i4a, i4b) *
                                            TVertex(i5, i5a, i5b) *
                                            TEdge(i1b, i2a) *
                                            TEdge(i2b, i3a) *
                                            TEdge(i3b, i4a) *
                                            TEdge(i4b, i5a) *
                                            TEdge(i5b, i1a)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return rtn;
end

tStar = [TStar(i1, i2, i3, i4, i5) for i1 in [1, 2],
                                        i2 in [1, 2],
                                        i3 in [1, 2],
                                        i4 in [1, 2],
                                        i5 in [1, 2]]

@show tStar[1,1,1,1,1]

function THalf(o1a, o1b, o2a, o2b, o3a, o3b, o4a, o4b, o5a, o5b)
    rtn = 0
    for c1 in [1, 2]
        for c2 in [1, 2]
            for c3 in [1, 2]
                for c4 in [1, 2]
                    for c5 in [1, 2]
                        for m1 in [1, 2]
                            for m2 in [1, 2]
                                for m3 in [1, 2]
                                    for m4 in [1, 2]
                                        for m5 in [1, 2]
    for m1a in [1, 2]
        for m2a in [1, 2]
            for m3a in [1, 2]
                for m4a in [1, 2]
                    for m5a in [1, 2]
                        for m1b in [1, 2]
                            for m2b in [1, 2]
                                for m3b in [1, 2]
                                    for m4b in [1, 2]
                                        for m5b in [1, 2]
                                            rtn +=
                                            tStar[c1, c2, c3, c4, c5] *
                                            tStar[m1, m1a, m1b, o1a, o1b] *
                                            tStar[m2, m2a, m2b, o2a, o2b] *
                                            tStar[m3, m3a, m3b, o3a, o3b] *
                                            tStar[m4, m4a, m4b, o4a, o4b] *
                                            tStar[m5, m5a, m5b, o5a, o5b] *
                                            TEdge(c1, m1) *
                                            TEdge(c2, m2) *
                                            TEdge(c3, m3) *
                                            TEdge(c4, m4) *
                                            TEdge(c5, m5) *
                                            TEdge(m1b, m2a) *
                                            TEdge(m2b, m3a) *
                                            TEdge(m3b, m4a) *
                                            TEdge(m4b, m5a) *
                                            TEdge(m5b, m1a)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return rtn
end

@show THalf(1,1,1,1,1,1,1,1,1,1)

tHalf = [THalf(o1a, o1b, o2a, o2b, o3a, o3b, o4a, o4b, o5a, o5b) for o1a in [1, 2],
                                                                o2a in [1, 2],
                                                                o3a in [1, 2],
                                                                o4a in [1, 2],
                                                                o5a in [1, 2],
                                                                o1b in [1, 2],
                                                                o2b in [1, 2],
                                                                o3b in [1, 2],
                                                                o4b in [1, 2],
                                                                o5b in [1, 2]]

@show tHalf[1,1,1,1,1,1,1,1,1,1]

function final()
    rtn = 0
    for i1a in [1, 2]
        for i2a in [1, 2]
            for i3a in [1, 2]
                for i4a in [1, 2]
                    for i5a in [1, 2]
                        for i1b in [1, 2]
                            for i2b in [1, 2]
                                for i3b in [1, 2]
                                    for i4b in [1, 2]
                                        for i5b in [1, 2]
    for m1a in [1, 2]
        for m2a in [1, 2]
            for m3a in [1, 2]
                for m4a in [1, 2]
                    for m5a in [1, 2]
                        for m1b in [1, 2]
                            for m2b in [1, 2]
                                for m3b in [1, 2]
                                    for m4b in [1, 2]
                                        for m5b in [1, 2]
                                            rtn +=
                                            tHalf[i1a, i1b, i2a, i2b, i3a, i3b, i4a, i4b, i5a, i5b] *
                                            tHalf[m1a, m1b, m2a, m2b, m3a, m3b, m4a, m4b, m5a, m5b] *
                                            TEdge(i1b, m1a) *
                                            TEdge(m1b, i2a) *
                                            TEdge(i2b, m2a) *
                                            TEdge(m2b, i3a) *
                                            TEdge(i3b, m3a) *
                                            TEdge(m3b, i4a) *
                                            TEdge(i4b, m4a) *
                                            TEdge(m4b, i5a) *
                                            TEdge(i5b, m5a) *
                                            TEdge(m5b, i1a)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return rtn;
end
@show Z=final()
@show log(Z)/60
